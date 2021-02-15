class MessageRoom < ApplicationRecord
  has_many :messages, dependent: :destroy
  has_many :message_room_users, dependent: :destroy
  has_many :users, through: :message_room_users

  def not_current_user(user)
    users.where.not(id: user.id).first
  end
end
