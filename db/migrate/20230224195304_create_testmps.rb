class CreateTestmps < ActiveRecord::Migration[7.0]
  def change
    create_table :testmps do |t|

      t.timestamps
    end
  end
end
