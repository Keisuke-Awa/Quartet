class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         #:confirmable, 
         :lockable, :timeoutable, :trackable,
         :omniauthable, omniauth_providers: [:facebook]


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
  has_many :message_room_users, dependent: :destroy
  has_many :message_rooms, through: :message_room_users, dependent: :destroy

  has_many :meetings, foreign_key: "planning_user_id", dependent: :destroy
  has_many :meeting_applications, foreign_key: "applicant_id", dependent: :destroy
  has_many :applying_meetings, through: :meeting_applications, source: :meeting

  has_many :user_appointments, dependent: :destroy
  has_many :appointments, through: :user_appointments

  belongs_to :residence, class_name: 'PrefectureMst'

  has_one :sns_credential, dependent: :destroy

  validates :name, presence: true, length: { maximum: 30 }
  # validates :email, presence: true, email: true

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

  def apply_meeting(meeting)
    applying_meetings << meeting
  end

  def unapply_meeting(meeting)
    meeting_applications.find_by(meeting_id: meeting.id).destroy
  end

  def applying?(meeting)
    applying_meetings.include?(meeting)
  end

  def make_appointment(appointment, other_user)
    appointments << appointment
    other_user.appointments << appointment
  end

  def destroy_appointment(meeting, other_user)
    appointments.find_by(meeting_id: meeting.id).destroy!
    other_user.appointments.find_by(meeting_id: meeting.id).destroy!
  end

  def self.sign_up_by_sns_credential(auth)
    user = User.where(email: auth.info.email).first
    if user.present?
      sns_credential = SnsCredential.create(
        uid: auth.uid,
        provider: auth.provider,
        user_id: user.id
      )
    else
      user = User.new(
        email: auth.info.email
      )
      sns_credential = SnsCredential.new(
        uid: auth.uid,
        provider: auth.provider
      )
    end
    return { user: user, sns_credential: sns_credential }
  end

  def self.sign_in_by_sns_credential(auth, sns_credential)
    user = User.where(id: sns_credential.user_id).first
    unless user.present?
      user = User.new(
        email: auth.info.email
      )
    end
    return { user: user}
  end

  def self.find_for_oauth(auth)
    sns_credential = SnsCredential.where(uid: auth.uid, provider: auth.provider).first
    if sns_credential.present?
      user = sign_in_by_sns_credential(auth, sns_credential)[:user]
    else
      user = sign_up_by_sns_credential(auth)[:user]
    end
    return { user: user, sns_credential: sns_credential }
  end

  # def self.find_for_oauth(auth)
  #   user = SnsCredential.where(uid: auth.uid, provider: auth.provider).first

  #   unless user
  #     info = SnsCredential.create(
  #       uid:      auth.uid,
  #       provider: auth.provider,
  #     #   email:    auth.info.email,
  #     #   name:  auth.info.name,
  #     #   password: Devise.friendly_token[0, 20],
  #     #   image:  auth.info.image
  #      )
  #   end

  #   user
  # end
end