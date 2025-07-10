class FoodRestriction < ApplicationRecord
  has_many :food_restriction_participants, dependent: :destroy_async
  has_many :participant, through: :food_restriction_participants
end
