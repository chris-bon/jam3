# frozen_string_literal: true
require 'spec_helper'

module Thredded
  describe TopicsController do
    routes { Thredded::Engine.routes }

    before do
      user          = create(:user)
      @messageboard = create(:messageboard)
      @topic        = create(:topic, messageboard: @messageboard, title: 'hi')
      @post         = create(:post, postable: @topic, content: 'hi')
      allow(controller).to receive_messages(
        topics:        [@topic],
        sticky_topics: [],
        cannot?:       false,
        current_user:  user,
        messageboard:  @messageboard
      )
    end

    it 'renders GET index' do
      get :index, messageboard_id: @messageboard.id

      expect(response).to be_successful
      expect(response).to render_template('index')
    end

    describe 'GET search' do
      it 'renders search' do
        allow(Topic).to receive_messages(search_query: Topic.where(id: @topic.id))
        get :search, messageboard_id: @messageboard.id, q: 'hi'

        expect(response).to be_successful
        expect(response).to render_template('search')
      end

      it 'is successful with spaces around search term(s)' do
        allow(Topic).to receive_messages(search_query: Topic.where(id: @topic.id))
        get :search, messageboard_id: @messageboard.id, q: '  hi  '

        expect(response).to be_successful
      end

      context 'renders' do
        render_views

        it 'a No Results message' do
          allow(Topic).to receive_messages(search_query: Topic.none)
          get :search, messageboard_id: @messageboard.id, q: 'hi'

          expect(response.body).to have_content "There are no results for your search - 'hi'"
        end
      end
    end
    describe 'GET new' do
      it 'works with no extra parameters' do
        get :new, messageboard_id: @messageboard.id
        expect(response).to be_successful
        expect(response).to render_template('new')
        expect(assigns(:new_topic).title).to be_blank
        expect(assigns(:new_topic).content).to be_blank
      end
      it 'assigns extra parameters' do
        get :new, messageboard_id: @messageboard.id, topic: { title: 'given title', content: 'preset content' }
        expect(response).to be_successful
        expect(response).to render_template('new')
        expect(assigns(:new_topic).title).to eq 'given title'
        expect(assigns(:new_topic).content).to eq 'preset content'
      end
    end
  end
end
