class ChangeColumnToTags < ActiveRecord::Migration[6.0]
  def change
    remove_reference :tags, :tag_category, null: false, foreign_key: true
    add_reference :tags, :tag_category, foreign_key: true
  end
end
