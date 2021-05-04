class Place < ApplicationRecord
  belongs_to :prefecture, class_name: 'PrefectureMst'

  scope :same_prefecture_as, -> (user) { where(prefecture: user.residence_id) }
end
