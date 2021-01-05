class Meeting < ApplicationRecord
  belongs_to :planning_user, class_name: "User"
  belongs_to :place

  has_many :meeting_applications, dependent: :destroy
  # has_many :applicants, through: :meeting_application, source: :applicant

  belongs_to :appointment, optional: true

  acts_as_taggable_on :tags

end
