class RenameBetterDonesToDones < ActiveRecord::Migration[5.1]
  def change
    rename_table :better_dones, :dones
  end
end
