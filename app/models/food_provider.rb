class FoodProvider < ApplicationRecord
  include Humanized
  include Defaultable

  has_many :participants, dependent: :nullify
  has_many :lunches, dependent: :nullify
end
