class CreateDones < ActiveRecord::Migration[5.0]
  def up
    create_table :dones do |t|
      t.text :text

      t.timestamps
    end

    change_column :dones, :created_at, :date
    change_column :dones, :updated_at, :date
  end

  def down
    raise "Don't delete shit"
  end
end
