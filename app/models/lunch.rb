class Lunch < ApplicationRecord
  belongs_to :participant
  belongs_to :user

  broadcasts

  delegate :name, to: :participant, prefix: true, allow_nil: true
  delegate :name, to: :user, prefix: true, allow_nil: true

  enum :kind, { kosher: "kosher", halal: "halal", vegetarian: "vegetarian", vegan: "vegan", peciterians: "peciterians",
                without_restrictions: "without_restrictions" }

  class << self
    def humanized_kinds
      kinds.map { |key, value| [ human_attribute_name("kind/#{value}"), key ] }
    end
  end
end
