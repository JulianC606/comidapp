class AddDeliveryDateToLunch < ActiveRecord::Migration[8.0]
  def change
    add_column :lunches, :delivery_date, :date
  end
end
