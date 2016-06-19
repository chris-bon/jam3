# frozen_string_literal: true
require_dependency 'thredded/posts_page_view'
require_dependency 'thredded/topics_page_view'
module Thredded
  class TopicsController < Thredded::ApplicationController
    before_action :thredded_require_login!,
                  only: %i(edit new update create destroy follow unfollow)
    after_action :update_user_activity

    after_action :verify_authorized, except: %i(search)
    after_action :verify_policy_scoped, except: %i(show new create edit update destroy follow unfollow)

    def index
      authorize_reading messageboard

      @topics = Thredded::TopicsPageView.new(
        thredded_current_user,
        policy_scope(messageboard.topics)
          .order_sticky_first.order_recently_updated_first
          .includes(:categories, :last_user, :user)
          .page(current_page)
      )
      TopicForm.new(messageboard: messageboard, user: thredded_current_user).tap do |form|
        @new_topic = form if policy(form.topic).create?
      end
    end

    def show
      authorize topic, :read?
      page_scope = policy_scope(topic.posts)
        .order_oldest_first
        .includes(:user, :messageboard, :postable)
        .page(current_page)
      @posts = Thredded::TopicPostsPageView.new(thredded_current_user, topic, page_scope)

      UserTopicReadState.touch!(thredded_current_user.id, topic.id, page_scope.last, current_page) if signed_in?

      @new_post = messageboard.posts.build(postable: topic)
    end

    def search
      authorize_reading messageboard if messageboard_or_nil
      @query = params[:q].to_s
      topics_scope = policy_scope(
        if messageboard_or_nil
          messageboard.topics
        else
          Topic.where(messageboard_id: policy_scope(Messageboard.all).pluck(:id))
        end
      )
      @topics = Thredded::TopicsPageView.new(
        thredded_current_user,
        topics_scope
          .search_query(@query)
          .order_recently_updated_first
          .includes(:categories, :last_user, :user)
          .page(current_page)
      )
    end

    def new
      @new_topic = TopicForm.new(new_topic_params)
      authorize_creating @new_topic.topic
    end

    def category
      authorize_reading messageboard
      @category = messageboard.categories.friendly.find(params[:category_id])
      @topics = Thredded::TopicsPageView.new(
        thredded_current_user,
        policy_scope(@category.topics)
          .unstuck
          .order_recently_updated_first
          .page(current_page)
      )
      render :index
    end

    def create
      @new_topic = TopicForm.new(new_topic_params)
      authorize_creating @new_topic.topic
      if @new_topic.save
        redirect_to messageboard_topics_path(messageboard)
      else
        render :new
      end
    end

    def edit
      authorize topic, :update?
    end

    def update
      authorize topic, :update?
      if topic.update(topic_params.merge(last_user_id: thredded_current_user.id))
        redirect_to messageboard_topic_url(messageboard, topic),
                    notice: t('thredded.topics.updated_notice')
      else
        render :edit
      end
    end

    def destroy
      authorize topic, :destroy?
      topic.destroy!
      redirect_to messageboard_topics_path(messageboard),
                  notice: t('thredded.topics.deleted_notice')
    end

    def follow
      authorize topic, :read?
      UserTopicFollow.create_unless_exists(thredded_current_user.id, topic.id)
      redirect_to messageboard_topic_url(messageboard, topic),
                  notice: t('thredded.topics.followed_notice')
    end

    def unfollow
      authorize topic, :read?
      follow = thredded_current_user.following?(topic)
      follow.destroy if follow
      redirect_to messageboard_topic_url(messageboard, topic),
                  notice: t('thredded.topics.unfollowed_notice')
    end

    private

    def topic
      @topic ||= messageboard.topics.find_by_slug!(params[:id])
    end

    def topic_params
      params
        .require(:topic)
        .permit(:title, :locked, :sticky, category_ids: [])
    end

    def new_topic_params
      params
        .fetch(:topic, {})
        .permit(:title, :locked, :sticky, :content, category_ids: [])
        .merge(
          messageboard: messageboard,
          user: thredded_current_user,
          ip: request.remote_ip,
        )
    end

    def current_page
      (params[:page] || 1).to_i
    end
  end
end
