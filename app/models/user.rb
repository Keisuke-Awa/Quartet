class User < ApplicationRecord

  require 'date'
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  after_save :default_avatar
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         #:confirmable, 
         :lockable, :timeoutable, :trackable,
         :omniauthable, omniauth_providers: [:facebook]


  has_one_attached :avatar
  
  has_many :messages, dependent: :destroy
  has_many :message_room_users, dependent: :destroy
  has_many :message_rooms, through: :message_room_users, dependent: :destroy

  has_many :meetings, foreign_key: "planning_user_id", dependent: :destroy
  has_many :meeting_applications, foreign_key: "applicant_id", dependent: :destroy
  has_many :applying_meetings, through: :meeting_applications, source: :meeting

  has_many :user_appointments, dependent: :destroy
  has_many :appointments, through: :user_appointments, dependent: :destroy

  belongs_to :residence, class_name: 'PrefectureMst'

  has_one :sns_credential, dependent: :destroy

  has_one :user_profile, dependent: :destroy
  # accepts_nested_attributes_for :user_profile

  has_many :new_arrivals, dependent: :destroy

  validates :name, presence: true, length: { maximum: 12 }
  validates :email, presence: true
  validates :birth_date, presence: true
  # 1: 男, 2: 女
  validates :sex, presence: true, inclusion: { in: %w(1 2) }
  validates :residence, presence: true
  validates :password, presence: true, on: :create
  validates :password_confirmation, presence: true, on: :create

  validate :over_twenty?, on: :create
  validate :valid_age?, on: :create

  scope :select_partner, -> (user) { where.not(id: user.id).first }
  scope :select_same_generation, -> (user) { where(birth_date: user.birth_date - 3.years..user.birth_date + 3.years) }


  def default_avatar
    unless avatar.attached?
      avatar.attach(io: File.open(Rails.root.join('public', 'assets', 'images', 'default-icon.jpg')), filename: 'default-icon.jpg',
                        content_type: 'image/jpg')
    end
  end

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
      # if auth.extra.raw_info.birthday
      #   birth_date = Date.strptime(auth.extra.raw_info.birthday, '%m/%d/%Y')
      # end
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
      # if auth.extra.raw_info.birthday
      #   birth_date = Date.strptime(auth.extra.raw_info.birthday, '%m/%d/%Y')
      # end
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

  def register_introduction?
    user_profile.introduction.present?
  end

  def register_height?
    user_profile.height.present?
  end
  
  def register_weight?
    user_profile.weight.present?
  end

  def register_blood_type?
    user_profile.blood_type.present?
  end

  def register_birthplace?
    user_profile.birthplace.present?
  end

  def register_occupation?
    user_profile.occupation.present?
  end

  def register_educational_bg?
    user_profile.educational_bg.present?
  end

  def register_annual_income?
    user_profile.annual_income.present?
  end

  def register_smoking?
    user_profile.smoking.present?
  end

  # ゲストユーザー作成
  def self.guest
    find_or_create_by!(email: 'guest@sample.com') do |user|
      user.password = SecureRandom.urlsafe_base64(8)
      user.password_confirmation = user.password
      user.name = "ゲストユーザー"
      user.sex = "1"
      user.residence_id = 13
      user.birth_date = Faker::Date.birthday(min_age: 20, max_age: 40)
    end
  end

  def age
    today_i = Date.today.strftime("%Y%m%d").to_i
    birthdate_i = birth_date.strftime("%Y%m%d").to_i
    return (today_i - birthdate_i) / 10000
  end

  def over_twenty?
    return if birth_date < Date.today - 20.years
    errors.add(:base, "20歳未満の方は、登録できません。")
  end

  def valid_age?
    return if birth_date > Date.today - 70.years
    errors.add(:base, "不正な年齢が入力されてます。")
  end

end