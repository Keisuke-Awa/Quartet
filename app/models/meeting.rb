class Meeting < ApplicationRecord
  belongs_to :planning_user, class_name: "User", foreign_key: "user_id"
  belongs_to :place

  has_many :meeting_applications, dependent: :destroy
  # has_many :applicants, through: :meeting_application, source: :applicant

  belongs_to :appointment
end
