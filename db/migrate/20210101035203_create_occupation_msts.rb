class CreateOccupationMsts < ActiveRecord::Migration[6.0]
  def change
    create_table :occupation_msts do |t|
      t.string :occupation_name

      t.timestamps
    end
  end
end
