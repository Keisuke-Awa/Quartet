class AddAppointmentIdToMessageRoom < ActiveRecord::Migration[6.0]
  def change
    add_reference :message_rooms, :appointment, null: false, foreign_key: true
  end
end
