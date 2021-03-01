class ChangeDataDetailToMeetings < ActiveRecord::Migration[6.0]
  def up
    change_column :meetings, :detail, :text
  end

  def down
    change_column :meetings, :detail, :string
  end
end
