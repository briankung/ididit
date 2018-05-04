class AddDayReferenceToDones < ActiveRecord::Migration[5.0]
  def up
    add_reference :dones, :day, foreign_key: true
  end

  def down
    remove_reference :dones, :day
  end
end
