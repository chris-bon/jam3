# frozen_string_literal: true
module Thredded
  class Category < ActiveRecord::Base
    extend FriendlyId
    belongs_to :messageboard
    has_many :topic_categories
    has_many :topics, through: :topic_categories
    friendly_id :name, use: [:history, :scoped], scope: :messageboard

    validates :name, presence: true
    validates :messageboard_id, presence: true
  end
end
