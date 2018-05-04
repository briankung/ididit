class AddIndexesToDones < ActiveRecord::Migration[5.0]
  def change
    add_index :dones, :text
    add_index :dones, :created_at
    add_index :dones, :updated_at
  end
end
