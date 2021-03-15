class MeetingApplication < ApplicationRecord
  belongs_to :meeting
  belongs_to :applicant, class_name: "User"

  scope :select_by, -> (user) { eager_load(meeting: :planning_user).where(meetings: {planning_user_id: user.id}) }
  scope :with_meeting_place, -> { eager_load(meeting: :place) }
  scope :with_meeting_user_avatar , -> { eager_load(meeting: {planning_user: {avatar_attachment: :blob}}) }
  scope :with_meeting_all, -> { with_meeting_place.with_meeting_user_avatar }

end
