class UserAppointment < ApplicationRecord
  belongs_to :user
  belongs_to :appointment

  scope :select_by, -> (user) { where(user_id: user.id).select("appointment_id") }
end
