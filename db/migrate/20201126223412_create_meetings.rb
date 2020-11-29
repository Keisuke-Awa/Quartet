class CreateMeetings < ActiveRecord::Migration[6.0]
  def change
    create_table :meetings do |t|
      t.datetime :meet_at
      t.integer :people
      t.string :place
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
