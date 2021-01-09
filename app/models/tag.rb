class Tag < ApplicationRecord
  belongs_to :tag_category
  has_ancestry
  acts_as_taggable
end
