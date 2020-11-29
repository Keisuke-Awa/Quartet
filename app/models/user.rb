class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         #:confirmable, 
         :lockable, :timeoutable, :trackable,
         :omniauthable, omniauth_providers: [:google_oauth2]

  # has_many :sns_credentials, dependent: :destroy

  has_one_attached :avatar

  # has_many :active_friend_requests, class_name: "FriendRequest",
  #                   foreign_key: "from_user_id", dependent: :destroy
  # has_many :passive_friend_requests, class_name: "FriendRequest",
  #                   foreign_key: "to_user_id", dependent: :destroy
  # has_many :requesting_users, through: :active_friend_requests, source: :to_user
  # has_many :requested_users, through: :passive_friend_requests, source: :from_user

  # has_many :friendships #dependent: :destroy
  # has_many :friends, through: :friendships
  
  has_many :messages, dependent: :destroy
  has_many :room_users, dependent: :destroy
  has_many :rooms, through: :room_users, dependent: :destroy

  has_many :meetings, dependent: :destroy

  validates :name, presence: true, length: { maximum: 30 }

  # def request_friendship(other_user)
  #   requesting_users << other_user
  # end

  # def unrequest_friendship(other_user)
  #   active_friend_requests.find_by(to_user_id: other_user.id).destroy
  # end

  # def requesting?(other_user)
  #   requesting_users.include?(other_user)
  # end

  # def destroy_friendship_request_for_admin(other_user)
  #   passive_friend_requests.find_by(from_user_id: other_user.id).destroy
  # end

  # def admin_friendship(other_user)
  #   friends << other_user
  #   other_user.friends << self
  # end

  # def is_friend?(other_user)
  #   friends.include?(other_user)
  # end

  # def destroy_friendship(other_user)
  #   friendships.find_by(friend_id: other_user.id).destroy
  #   other_user.friendships.find_by(friend_id: self.id).destroy
  # end
end
