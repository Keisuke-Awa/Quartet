class ChangeFacebookIdentificationsToSnsCredentials < ActiveRecord::Migration[6.0]
  def change
    rename_table :facebook_identifications, :sns_credentials
  end
end
