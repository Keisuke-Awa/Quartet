class RemoveAncestryFromTagCategories < ActiveRecord::Migration[6.0]
  def change
    remove_column :tag_categories, :ancestry, :string
  end
end
