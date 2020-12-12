class RemoveUserFromMeetings < ActiveRecord::Migration[6.0]
  def change
    remove_reference :meetings, :user, null: false, foreign_key: true
  end
end
