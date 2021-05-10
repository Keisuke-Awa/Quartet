class DeleteMealTypeCategories < ActiveRecord::Migration[6.0]
  def change
    drop_table :meal_type_categories do |t|
      t.string :name, null: false
      t.timestamps null: false
    end
  end
end
