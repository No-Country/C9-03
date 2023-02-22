class ChangeStoreidToBeNull < ActiveRecord::Migration[7.0]
  def change
    change_column_null :locations, :store_id, true 
  end
end
