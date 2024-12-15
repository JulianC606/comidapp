class Participant < ApplicationRecord
  enum :restrictions, { kosher: "kosher", halal: "halal", vegetarian: "vegetarian", vegan: "vegan",
                        without_restrictions: "without_restrictions" }

  has_many :lunches, dependent: :destroy
end
