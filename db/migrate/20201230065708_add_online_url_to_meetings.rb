class AddOnlineUrlToMeetings < ActiveRecord::Migration[6.0]
  def change
    add_column :meetings, :online_url, :text
  end
end
