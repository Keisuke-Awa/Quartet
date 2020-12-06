class MeetingApplication < ApplicationRecord
  belongs_to :meeting
  belongs_to :applicant, class_name: "User", foreign_key: "user_id"
end
