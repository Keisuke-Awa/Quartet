class CreateTagCategories < ActiveRecord::Migration[6.0]
  def change
    create_table :tag_categories do |t|
      t.string :category_name
      t.string :ancestry

      t.timestamps
    end
    add_index :tag_categories, :ancestry
  end
end
