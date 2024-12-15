class Current < ActiveSupport::CurrentAttributes
  attribute :session
  delegate :user, :user_id, to: :session, allow_nil: true

  delegate :name, :admin?, to: :user, prefix: true, allow_nil: true
end
