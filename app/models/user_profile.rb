class UserProfile < ApplicationRecord
  belongs_to :user
  belongs_to :birthplace, class_name: 'PrefectureMst', optional: true
  belongs_to :occupation, class_name: 'OccupationMst', optional: true
  belongs_to :educational_bg, class_name: 'EducationalBgMst', optional: true
  belongs_to :annual_income, class_name: 'AnnualIncomeMst', optional: true
  belongs_to :smoking_status, class_name: 'SmokingMst', optional: true
end
