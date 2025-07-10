class CreateFoodProviders < ActiveRecord::Migration[8.0]
  def change
    create_table :food_providers do |t|
      t.string :name
      t.boolean :default, default: false

      t.timestamps
    end
  end
end
