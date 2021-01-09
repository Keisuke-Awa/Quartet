class DropTagTable < ActiveRecord::Migration[6.0]
  def change
    drop_table :meal_type_tag_meetings
    drop_table :meal_type_tags
    drop_table :meal_type_categories
  end
end
