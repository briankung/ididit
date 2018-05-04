class CreatePosts < ActiveRecord::Migration[5.0]
  def up
    create_table :posts do |t|
      t.string :title
      t.text :body

      t.timestamps
    end
  end

  def down
    raise "Don't delete shit"
  end
end
