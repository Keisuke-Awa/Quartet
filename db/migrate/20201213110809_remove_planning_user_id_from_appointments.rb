class RemovePlanningUserIdFromAppointments < ActiveRecord::Migration[6.0]
  def change
    remove_reference :appointments, :planning_user, null: false, foreign_key: { to_table: :users }
  end
end
