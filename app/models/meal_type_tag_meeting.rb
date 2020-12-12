class MealTypeTagMeeting < ApplicationRecord
  belongs_to :meeting
  belongs_to :meal_type_tag
end
