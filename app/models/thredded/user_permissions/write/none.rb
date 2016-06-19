# frozen_string_literal: true
module Thredded
  module UserPermissions
    module Write
      module None
        extend ActiveSupport::Concern
        included { extend ClassMethods }

        # @return [ActiveRecord::Relation<Thredded::Messageboard>] messageboards that the user can post in
        def thredded_can_write_messageboards
          Thredded::Messageboard.none
        end

        module ClassMethods
          # Users that can post to the given messageboards.
          #
          # @param _messageboards [Array<Thredded::Messageboard>]
          # @return [ActiveRecord::Relation<Thredded.user_class>] users that can post to the given messageboards
          def thredded_messageboards_writers(_messageboards)
            none
          end
        end
      end
    end
  end
end
