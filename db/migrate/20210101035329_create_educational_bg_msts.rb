class CreateEducationalBgMsts < ActiveRecord::Migration[6.0]
  def change
    create_table :educational_bg_msts do |t|
      t.string :ebg_name

      t.timestamps
    end
  end
end
