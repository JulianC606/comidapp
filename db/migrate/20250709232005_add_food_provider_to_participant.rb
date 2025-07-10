class AddFoodProviderToParticipant < ActiveRecord::Migration[8.0]
  def change
    add_reference :participants, :food_provider, null: false, foreign_key: true
  end
end
