class FoodRestriction < ApplicationRecord
  include Humanized

  has_many :food_restriction_participants, dependent: :destroy
  has_many :participant, through: :food_restriction_participants

  enum :kind, { "allergy" => "allergy", "religious"=>"religious", "other" => "other"  }

  class << self
    def humanized_kinds
      kinds.map { |key, value| [ human_attribute_name("kind/#{value}"), key ] }
    end
  end
end
