class AddBarCodeToParticipants < ActiveRecord::Migration[8.0]
  def change
    add_column :participants, :barcode, :string
  end
end
