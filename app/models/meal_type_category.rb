class MealTypeCategory < ApplicationRecord
  has_many :meal_type_tags
end