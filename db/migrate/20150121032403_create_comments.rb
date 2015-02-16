class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.references :post, index: true
      t.text :content
      t.references :user, index: true
      t.text :author

      t.timestamps
    end
    add_index :comments, [:post_id, :created_at]
  end
end
