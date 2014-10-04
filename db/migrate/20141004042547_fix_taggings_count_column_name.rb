class FixTaggingsCountColumnName < ActiveRecord::Migration
  def change
  	rename_column :tags, :tagging_count, :taggings_count
  end
end
