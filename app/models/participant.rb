class Participant < ApplicationRecord
  include FoodRestrictionable

  ROLES = { speaker: "speaker",
            adjudicator: "adjudicator",
            volunteer: "volunteer",
            host: "host",
            academic_team: "academic_team",
            observer: "observer" }.freeze

  enum :role, ROLES
end
