class CreateFoodRestrictions < ActiveRecord::Migration[8.0]
  def change
    create_table :food_restrictions do |t|
      t.string :name
      t.string :kind

      t.timestamps
    end
  end
end
