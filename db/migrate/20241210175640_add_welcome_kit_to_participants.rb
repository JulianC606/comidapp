class AddWelcomeKitToParticipants < ActiveRecord::Migration[8.0]
  def change
    add_column :participants, :welcome_kit, :boolean
  end
end
