class CreateDelegations < ActiveRecord::Migration[8.0]
  def change
    create_table :delegations do |t|
      t.string :name
      t.integer :participants_count

      t.timestamps
    end
  end
end
