class CreateFacebookIdentifications < ActiveRecord::Migration[6.0]
  def change
    create_table :facebook_identifications do |t|
      t.string :uid
      t.string :provider
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
