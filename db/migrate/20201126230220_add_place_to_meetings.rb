class AddPlaceToMeetings < ActiveRecord::Migration[6.0]
  def change
    add_reference :meetings, :place, null: false, foreign_key: true
  end
end
