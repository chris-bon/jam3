# frozen_string_literal: true
module Thredded
  # A view model for PrivateTopic.
  class PrivateTopicView < BaseTopicView
    def edit_path
    end

    def self.from_user topic, user
      read_state = if user && !user.thredded_anonymous?
                     UserPrivateTopicReadState
                       .find_by user_id: user.id, postable_id: topic.id
                   end
      new topic, read_state, Pundit.policy!(user, topic)
    end
  end
end
