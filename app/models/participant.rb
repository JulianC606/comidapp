class Participant < ApplicationRecord
  has_many :lunches, dependent: :destroy_async
  has_many :food_restriction_participants, dependent: :destroy_async
  has_many :food_restrictions, through: :food_restriction_participants
  belongs_to :food_provider


  ROLES = { speaker: "speaker",
            adjudicator: "adjudicator",
            volunteer: "volunteer",
            host: "host",
            academic_team: "academic_team",
            observer: "observer" }.freeze

  enum :role, ROLES
end
