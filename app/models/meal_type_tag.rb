class MealTypeTag < ApplicationRecord
  belongs_to :category, class_name: "MealTypeCategory"
  has_many :meal_type_tag_meetings
  has_many :meetings, through: :meal_type_tag_meetings
end
