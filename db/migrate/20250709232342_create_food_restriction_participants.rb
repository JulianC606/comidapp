class CreateFoodRestrictionParticipants < ActiveRecord::Migration[8.0]
  def change
    create_table :food_restriction_participants do |t|
      t.references :food_restriction, null: false, foreign_key: true
      t.references :participant, null: false, foreign_key: true

      t.timestamps
    end
  end
end
