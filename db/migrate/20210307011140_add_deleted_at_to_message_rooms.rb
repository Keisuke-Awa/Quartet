class AddDeletedAtToMessageRooms < ActiveRecord::Migration[6.0]
  def change
    add_column :message_rooms, :deleted_at, :datetime
    add_index :message_rooms, :deleted_at
  end
end
