class AddRoleToParticipant < ActiveRecord::Migration[8.0]
  def change
    add_column :participants, :role, :string
  end
end
