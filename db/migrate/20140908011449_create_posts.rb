class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.integer :user_id
      t.text :title
      t.text :content

      t.timestamps
    end
    add_index :posts, :created_at
  end
end
