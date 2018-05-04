class DropDones < ActiveRecord::Migration[5.1]
  def change
    drop_table :dones
  end
end
