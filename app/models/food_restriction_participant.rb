class FoodRestrictionParticipant < ApplicationRecord
  belongs_to :food_restriction
  belongs_to :participant
end
