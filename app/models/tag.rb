class Tag < ApplicationRecord
  belongs_to :tag_category, optional: true
  has_ancestry
  acts_as_taggable

end
