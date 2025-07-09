module Defaultable
  extend ActiveSupport::Concern

  included do
    before_save :reset_default, if: :assigned_default?
  end

  private

  def assigned_default?
    default? && default_changed?
  end

  def reset_default
    self.class.where.not(id:).in_batches.each do |batch|
      batch.update_all(default: false)
    end
  end
end
