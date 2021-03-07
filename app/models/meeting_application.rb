class MeetingApplication < ApplicationRecord
  belongs_to :meeting
  belongs_to :applicant, class_name: "User"

  scope :select_by_partner, -> (user) { eager_load(meeting: :planning_user).where(meetings: {planning_user_id: user.id}) }

end
