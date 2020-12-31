class AddDetailToMeetingApplication < ActiveRecord::Migration[6.0]
  def change
    add_column :meeting_applications, :detail, :text
  end
end
