class CreateMeetingApplications < ActiveRecord::Migration[6.0]
  def change
    create_table :meeting_applications do |t|
      t.references :meeting, foreign_key: true, null: false
      t.references :applicant, foreign_key: { to_table: :users }, null: false

      t.timestamps
    end
  end
end
