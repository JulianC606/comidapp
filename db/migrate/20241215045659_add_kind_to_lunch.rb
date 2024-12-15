class AddKindToLunch < ActiveRecord::Migration[8.0]
  def change
    add_column :lunches, :kind, :string, default: 'without_restrictions'
  end
end
