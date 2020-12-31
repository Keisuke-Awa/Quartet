class AddAppointmentIdToMeeting < ActiveRecord::Migration[6.0]
  def change
    add_reference :meetings, :appointment, foreign_key: true
  end
end
