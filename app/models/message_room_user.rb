class MessageRoomUser < ApplicationRecord
  belongs_to :user
  belongs_to :message_room

  scope :select_by, -> (user) { where(user_id: user.id).select("message_room_id") }
end
