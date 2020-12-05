class Meeting < ApplicationRecord
<<<<<<< Updated upstream
  belongs_to :user
=======
  belongs_to :planning_user, class_name: "User", foreign_key: "user_id"
  belongs_to :place

  # belongs_to :user
>>>>>>> Stashed changes
end
