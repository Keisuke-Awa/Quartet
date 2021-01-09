class RemoveColumnFromTags < ActiveRecord::Migration[6.0]
  def change
    remove_column :tags, :tag_category_id_id, :bigint, null: false
  end
end
