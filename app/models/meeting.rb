class Meeting < ApplicationRecord

  belongs_to :planning_user, class_name: "User"
  belongs_to :place
  has_many :meeting_applications, dependent: :destroy
  # has_many :applicants, through: :meeting_application, source: :applicant
  belongs_to :appointment, optional: true

  acts_as_taggable_on :tags

  scope :as_of_now, -> { where(meet_at: DateTime.now..Float::INFINITY) }
  scope :not_match, -> { where(appointment_id: nil) }
  scope :include_user_avatar, -> { eager_load(planning_user: {avatar_attachment: :blob}) }
  scope :without_current_user, -> (user) { where.not(planning_user_id: user.id) }
  scope :is_different_gender, -> (user) { where.not(users: {sex: user.sex}) }
  scope :include_place, -> { eager_load(:place) }
  scope :paginate, -> (page) { page(page).per(30) }
  scope :display_list, -> (user, page) { as_of_now.not_match.include_user_avatar.without_current_user(user)
                                      .is_different_gender(user).include_place.paginate(page) }
end
