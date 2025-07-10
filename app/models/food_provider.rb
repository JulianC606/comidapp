class FoodProvider < ApplicationRecord
  include Humanized
  include Defaultable

  has_many :participants, dependent: :destroy_async
  has_many :lunches, dependent: :destroy_async
end
