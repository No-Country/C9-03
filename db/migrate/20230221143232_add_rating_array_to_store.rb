class AddRatingArrayToStore < ActiveRecord::Migration[7.0]
  def change
    add_column :stores, :ratings, :float,  array: true, default: []
  end
end
