class CreateAddresses < ActiveRecord::Migration[7.0]
  def change
    create_table :addresses do |t|
      t.string :street, null: false
      t.integer :zip, null: false
      t.references :store, null: false, foreign_key: true

      t.timestamps
    end
  end
end
