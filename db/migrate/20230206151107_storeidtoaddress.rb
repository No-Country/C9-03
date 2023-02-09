class Storeidtoaddress < ActiveRecord::Migration[7.0]
  def change
    add_reference :addresses, :store, null: false, foreign_key: true
  end
end
