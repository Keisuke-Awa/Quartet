class Meeting < ApplicationRecord
  belongs_to :planning_user, class_name: "User", foreign_key: "user_id"
  belongs_to :place

  has_many :meeting_application, dependent: :destroy
  has_many :applicant, through: :meeting_application, source: :applicant
end
