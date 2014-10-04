class AddTaggingCountToTag < ActiveRecord::Migration
  def change
    add_column :tags, :tagging_count, :integer
  end
end
