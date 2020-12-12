class CreateMealTypeTagCategories < ActiveRecord::Migration[6.0]
  def change
    create_table :meal_type_tag_categories do |t|
      t.string :name, null: false

      t.timestamps
    end
  end
end
