class RemoveTagCategoryIdIdFromTags < ActiveRecord::Migration[6.0]
  def change
    remove_column :tags, :tag_category_id, null: false, foreign_key: true
  end
end
