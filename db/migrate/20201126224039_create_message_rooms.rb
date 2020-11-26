class CreateMessageRooms < ActiveRecord::Migration[6.0]
  def change
    create_table :message_rooms do |t|

      t.timestamps
    end
  end
end
