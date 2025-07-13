class AddDeliveredAtToLunches < ActiveRecord::Migration[8.0]
  def change
    add_column :lunches, :delivered_at, :datetime
  end
end
