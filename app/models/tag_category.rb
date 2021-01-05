class TagCategory < ApplicationRecord
  has_many :tags
  has_ancestry
end
