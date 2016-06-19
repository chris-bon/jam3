# frozen_string_literal: true
require_dependency 'thredded/urls_helper'
module Thredded
  # A view model for TopicCommon.
  class BaseTopicView
    delegate :title,
             :posts_count,
             :updated_at,
             :created_at,
             :user,
             :last_user,
             :to_model,
             to: :@topic

    delegate :read?,
             to: :@read_state

    # @param topic [TopicCommon]
    # @param read_state [UserTopicReadStateCommon, nil]
    # @param policy [#destroy?]
    def initialize(topic, read_state, policy)
      @read_state = read_state || Thredded::NullUserTopicReadState.new
      @topic      = topic
      @policy     = policy
    end

    def states
      [@read_state.read? ? :read : :unread]
    end

    def can_update?
      @policy.update?
    end

    def can_destroy?
      @policy.destroy?
    end

    def path
      Thredded::UrlsHelper.topic_path(@topic, page: @read_state.page)
    end
  end
end
