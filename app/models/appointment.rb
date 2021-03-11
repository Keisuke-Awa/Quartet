class Appointment < ApplicationRecord
  belongs_to :meeting
  
  has_many :user_appointments, dependent: :destroy
  has_many :users, through: :user_appointments

  scope :select_by, -> (appointment_ids) { where(id: appointment_ids) }
  scope :select_one_by,
    -> (current_user_of_appointment_ids, partner_of_appointment_ids) { select_by(current_user_of_appointment_ids).select_by(partner_of_appointment_ids) }
end
