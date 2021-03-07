class MessageRoom < ApplicationRecord
  has_many :messages, dependent: :destroy
  has_many :message_room_users, dependent: :destroy
  has_many :users, through: :message_room_users

  def self.delete_by_appointment?(current_user, partner)
    leave_factory = current_user.meeting_applications.select_by_partner(partner) || partner.meeting_applications.select_by_partner(current_user) || current_user.appointments.select_by_partner(partner)
    leave_factory.present?
  end
end
