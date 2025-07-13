class Participant < ApplicationRecord
  include Humanized

  has_many :lunches, dependent: :nullify
  has_many :food_restriction_participants, dependent: :destroy_async
  has_many :food_restrictions, through: :food_restriction_participants
  belongs_to :food_provider, counter_cache: true


  ROLES = { speaker: "speaker",
            adjudicator: "adjudicator",
            volunteer: "volunteer",
            host: "host",
            academic_team: "academic_team",
            observer: "observer" }.freeze

  enum :role, ROLES

  delegate :name, to: :food_provider, allow_nil: true, prefix: true

  class << self
    def humanized_roles
      ROLES.map { |key, value| [ human_attribute_name("role/#{value}"), key ] }
    end
  end
end
