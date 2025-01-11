# frozen_string_literal: true

class Participant
  module FoodRestrictionable
    extend ActiveSupport::Concern

    FOOD_RESTRICTIONS = { kosher: "kosher",
    halal: "halal",
    vegetarian: "vegetarian",
    vegan: "vegan",
    pescatarians: "pescatarians",
    without_restrictions: "without_restrictions",
    gluten_free: "gluten_free",
    lactose_free: "lactose_free" }.freeze

    included do
      enum :restrictions, FOOD_RESTRICTIONS

      has_many :lunches, dependent: :destroy
    end
  end
end
