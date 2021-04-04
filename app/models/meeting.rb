class Meeting < ApplicationRecord

  belongs_to :planning_user, class_name: "User"
  belongs_to :place
  has_many :meeting_applications, dependent: :destroy
  # has_many :applicants, through: :meeting_application, source: :applicant
  belongs_to :appointment, optional: true

  acts_as_taggable_on :tags

  scope :as_of_now, -> { where(meet_at: DateTime.now..Float::INFINITY) }
  scope :exclude_appointed, -> { where(appointment_id: nil) }
  scope :with_planning_user, -> { eager_load(:planning_user) }
  scope :with_user_avatar, -> { eager_load(planning_user: {avatar_attachment: :blob}) }
  scope :exclude_current_user, -> (user) { where.not(planning_user_id: user.id) }
  scope :exclude_same_sex, -> (user) { where.not(users: {sex: user.sex}) }
  scope :with_place, -> { eager_load(:place) }
  scope :with_appointment, -> { eager_load(:appointment) }
  scope :paginate, -> (page) { page(page).per(30) }
  scope :display_list, -> (user, page) { as_of_now.exclude_appointed.with_user_avatar.exclude_current_user(user)
                                              .exclude_same_sex(user).with_place.paginate(page) }
  scope :search_with_appointment, -> (appointments) { where(appointment_id: appointments).with_user_avatar#.as_of_now
                                        .with_place.with_appointment }
end
