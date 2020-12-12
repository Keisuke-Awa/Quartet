class CreateMealTypeTags < ActiveRecord::Migration[6.0]
  def change
    create_table :meal_type_tags do |t|
      t.string :name, null: false
      t.references :category, null: false, foreign_key: { to_table: :meal_type_tag_categories}

      t.timestamps
    end
  end
end
