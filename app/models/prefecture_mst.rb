class PrefectureMst < ApplicationRecord
  has_many :places
  has_many :users
end
