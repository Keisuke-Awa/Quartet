class AddPlanningUserToMeetings < ActiveRecord::Migration[6.0]
  def change
    add_reference :meetings, :planning_user, null: false, foreign_key: { to_table: :users }
  end
end
