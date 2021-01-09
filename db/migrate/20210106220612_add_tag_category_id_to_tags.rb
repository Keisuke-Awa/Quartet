class AddTagCategoryIdToTags < ActiveRecord::Migration[6.0]
  def change
    add_reference :tags, :tag_category, null: false, foreign_key: true
  end
end
