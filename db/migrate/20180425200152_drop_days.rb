class DropDays < ActiveRecord::Migration[5.1]
  def change
    drop_table :days
  end
end
