class RemoveAppointmentFromMessageRooms < ActiveRecord::Migration[6.0]
  def change
    remove_reference :message_rooms, :appointment, null: false, foreign_key: true
  end
end
