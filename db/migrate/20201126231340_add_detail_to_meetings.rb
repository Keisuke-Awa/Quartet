class AddDetailToMeetings < ActiveRecord::Migration[6.0]
  def change
    add_column :meetings, :detail, :string
  end
end
