class RemoveMessageRoomIdFromAppointments < ActiveRecord::Migration[6.0]
  def change
    remove_reference :appointments, :message_room, null: false, foreign_key: true
  end
end
