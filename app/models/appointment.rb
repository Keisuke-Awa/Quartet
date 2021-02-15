class Appointment < ApplicationRecord
  belongs_to :meeting
  
  has_many :user_appointments, dependent: :destroy
  has_many :users, through: :user_appointments

  def not_current_user(user)
    users.where.not(id: user.id).first
  end
end
