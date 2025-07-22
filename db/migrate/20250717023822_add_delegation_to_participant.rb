class AddDelegationToParticipant < ActiveRecord::Migration[8.0]
  def change
    add_reference :participants, :delegation, null: true, foreign_key: true
  end
end
