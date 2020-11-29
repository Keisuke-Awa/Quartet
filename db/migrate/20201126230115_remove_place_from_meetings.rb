class RemovePlaceFromMeetings < ActiveRecord::Migration[6.0]
  def change
    remove_column :meetings, :place, :string
  end
end
