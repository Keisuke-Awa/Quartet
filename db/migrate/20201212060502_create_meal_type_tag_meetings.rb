class CreateMealTypeTagMeetings < ActiveRecord::Migration[6.0]
  def change
    create_table :meal_type_tag_meetings do |t|
      t.references :meeting, null: false, foreign_key: true
      t.references :meal_type_tag, null: false, foreign_key: true

      t.timestamps
    end
  end
end
