class Lunch < ApplicationRecord
  include Humanized
  belongs_to :participant
  belongs_to :user

  broadcasts

  delegate :name, to: :participant, prefix: true, allow_nil: true
  delegate :name, to: :user, prefix: true, allow_nil: true
  delegate :blank?, to: :kind, prefix: true

  enum :kind, { "breakfast" => "breakfast", "lunch" => "lunch", "dinner" => "dinner", "other" => "other" }

  after_initialize :calculate_kind, if: :kind_blank?

  paginates_per 10

  class << self
    def humanized_kinds
      kinds.map { |key, value| [ human_attribute_name("kind/#{value}"), key ] }
    end
  end

  def calculate_kind
    return if kind.present?
    return self.kind = "breakfast" if Time.current.at_morning?
    return self.kind = "lunch" if Time.current.at_afternoon?
    return self.kind = "dinned" if Time.current.at_evening?

    self.kind = "other"
  end
end
