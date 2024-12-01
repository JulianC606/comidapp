class CreateLunches < ActiveRecord::Migration[8.0]
  def change
    create_table :lunches do |t|
      t.references :participant, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
