class Meeting < ApplicationRecord
  belongs_to :planning_user, class_name: "User", foreign_key: "user_id"
  belongs_to :place

  # belongs_to :user
end
