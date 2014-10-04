class RemoveTagginsCountFromTag < ActiveRecord::Migration
  def change
    remove_column :tags, :taggings_count, :integer
  end
end
