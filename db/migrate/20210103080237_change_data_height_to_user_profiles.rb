class ChangeDataHeightToUserProfiles < ActiveRecord::Migration[6.0]
  def up
    change_column :user_profiles, :height, :integer
    change_column :user_profiles, :weight, :integer
  end

  def down
    change_column :user_profiles, :height, :string
    change_column :user_profiles, :weight, :string
  end
end
