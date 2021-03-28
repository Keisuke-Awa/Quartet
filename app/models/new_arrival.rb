class NewArrival < ApplicationRecord
  belongs_to :user

  scope :select_model, -> (content) { where(model: content) }
  scope :count_by, -> (content) { select_model(content).count }
end
