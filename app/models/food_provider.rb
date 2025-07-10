class FoodProvider < ApplicationRecord
  has_many :participants, dependent: :destroy_async
  has_many :lunches, dependent: :destroy_async
end
