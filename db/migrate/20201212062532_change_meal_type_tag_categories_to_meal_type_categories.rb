class ChangeMealTypeTagCategoriesToMealTypeCategories < ActiveRecord::Migration[6.0]
  def change
    rename_table :meal_type_tag_categories, :meal_type_categories
  end
end
