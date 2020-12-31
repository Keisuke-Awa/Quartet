class Meeting < ApplicationRecord
  belongs_to :planning_user, class_name: "User"
  belongs_to :place

  has_many :meeting_applications, dependent: :destroy
  # has_many :applicants, through: :meeting_application, source: :applicant

  has_many :meal_type_tag_meetings
  has_many :meal_type_tags, through: :meal_type_tag_meetings

  belongs_to :appointment, optional: true

end
