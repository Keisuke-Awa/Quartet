class RemoveAddUserIdToUserProfiles < ActiveRecord::Migration[6.0]
  def change
    drop_table :add_user_id_to_user_profiles
  end
end
