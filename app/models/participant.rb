class Participant < ApplicationRecord
  include FoodRestrictionable

  ROLES = { speaker: "speaker",
            adjudicator: "adjudicator",
            volunteer: "volunteer",
            host: "host",
            tab_director: "tab_director",
            tab: "tab",
            chief_adjudicator: "chief_adjudicator",
            deputy_chief_adjudicator: "deputy_chief_adjudicator",
            observer: "observer" }.freeze

  enum :role, ROLES
end
