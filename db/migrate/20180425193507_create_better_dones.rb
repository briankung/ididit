class CreateBetterDones < ActiveRecord::Migration[5.1]
  def change
    create_table :better_dones do |t|
      t.text :text
      t.date :date

      t.timestamps
    end
  end
end
