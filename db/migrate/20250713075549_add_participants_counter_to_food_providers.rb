class AddParticipantsCounterToFoodProviders < ActiveRecord::Migration[8.0]
  def change
    add_column :food_providers, :participants_count, :integer
  end
end
