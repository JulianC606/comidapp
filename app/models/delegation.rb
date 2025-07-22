class Delegation < ApplicationRecord
  has_many :participants, dependent: :nullify
end
