class CreateParticipants < ActiveRecord::Migration[8.0]
  def change
    create_table :participants, id: :uuid do |t|
      t.string :name
      t.string :restrictions

      t.timestamps
    end
  end
end
