class MessageRoom < ApplicationRecord
  include Discard::Model
  default_scope -> { kept }

  has_many :messages, dependent: :destroy
  has_many :message_room_users, dependent: :destroy
  has_many :users, through: :message_room_users


  scope :with_users, -> { preload(:users) }
  scope :with_message_room_users, -> { eager_load(:message_room_users) }
  scope :select_by, -> (ids) { where(id: ids) }
  scope :choice_by, -> (ids_of_current_user, ids_of_partner) { select_by(ids_of_current_user).select_by(ids_of_partner) }
  scope :choice_by_discarded, -> (ids_of_current_user, ids_of_partner) { with_discarded.discarded.choice_by(ids_of_current_user, ids_of_partner) }

  def self.delete_by_appointment?(current_user, partner)
    leave_elements = [Appointment.select_one_by(UserAppointment.select_by(current_user), UserAppointment.select_by(partner)),
          current_user.meeting_applications.select_by(partner), partner.meeting_applications.select_by(current_user)]
    leave_elements.each { |le| return false if le.exists? }
  end
end
