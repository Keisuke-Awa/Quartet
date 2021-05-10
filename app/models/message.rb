class Message < ApplicationRecord
  belongs_to :user
  belongs_to :message_room

  validates :content, presence: true, length: { maximum: 140 }

end
