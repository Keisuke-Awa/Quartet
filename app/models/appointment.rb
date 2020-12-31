class Appointment < ApplicationRecord
  belongs_to :meeting
  has_one :message_room
  
  has_many :user_appointments, dependent: :destroy
  has_many :users, through: :user_appointments
end
