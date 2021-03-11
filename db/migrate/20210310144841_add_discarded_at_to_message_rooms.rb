class AddDiscardedAtToMessageRooms < ActiveRecord::Migration[6.0]
  def change
    add_column :message_rooms, :discarded_at, :datetime
    add_index :message_rooms, :discarded_at
  end
end
