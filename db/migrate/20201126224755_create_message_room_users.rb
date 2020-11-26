class CreateMessageRoomUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :message_room_users do |t|
      t.references :user, null: false, foreign_key: true
      t.references :message_room, null: false, foreign_key: true

      t.timestamps
    end
  end
end
