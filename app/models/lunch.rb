class Lunch < ApplicationRecord
  belongs_to :participant
  belongs_to :user
end
