class CreateDays < ActiveRecord::Migration[5.0]
  def change
    create_table :days do |t|
      t.string :dones_order

      t.timestamps
    end
  end
end
