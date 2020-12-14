class RemoveApprovedUserIdFromAppointments < ActiveRecord::Migration[6.0]
  def change
    remove_reference :appointments, :approved_user, null: false, foreign_key: { to_table: :users }
  end
end
