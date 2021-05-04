class UserProfile < ApplicationRecord
  belongs_to :user
  belongs_to :birthplace, class_name: 'PrefectureMst', foreign_key: 'birthplace_id', optional: true
  belongs_to :occupation, class_name: 'OccupationMst', optional: true
  belongs_to :educational_bg, class_name: 'EducationalBgMst', optional: true
  belongs_to :annual_income, class_name: 'AnnualIncomeMst', optional: true
  belongs_to :smoking, class_name: 'SmokingMst', foreign_key: 'smoking_status_id', optional: true

  def self.guest(user)
    find_or_create_by!(user_id: user.id) do |user_profile|
      user_profile.height = 175
      user_profile.weight = 70
      user_profile.blood_type = "A"
      user_profile.birthplace_id = 13
      user_profile.occupation_id = Faker::Number.within(range: 1..5)
      user_profile.educational_bg_id = Faker::Number.within(range: 1..5)
      user_profile.annual_income_id = Faker::Number.within(range: 1..9)
      user_profile.smoking_status_id = Faker::Number.within(range: 1..5)
      user_profile.introduction = "初めまして！\nエンジニアとして働いている25歳です。\n\n職場に出会いがなさすぎて登録しました。\n飲み会に連れて行く友達は基本エンジニアです。\n\nよろしくお願いします！"
    end
  end
end
