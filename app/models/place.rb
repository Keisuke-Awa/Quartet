class Place < ApplicationRecord
  belongs_to :prefecture, class_name: 'PrefectureMst'
end
