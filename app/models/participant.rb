class Participant < ApplicationRecord
  enum :restrictions, { kosher: :kosher, halal: :halal, vegetarian: :vegetarian, vegan: :vegan }
end
