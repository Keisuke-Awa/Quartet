class Appointment < ApplicationRecord
  belongs_to :meeting
  belongs_to :planning_user, class_name: "User", foreign_key: "user_id"
  belongs_to :approved_user, class_name: "User", foreign_key: "user_id"
  belongs_to :message_room
end
