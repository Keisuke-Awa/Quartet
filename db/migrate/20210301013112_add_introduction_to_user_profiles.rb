class AddIntroductionToUserProfiles < ActiveRecord::Migration[6.0]
  def change
    add_column :user_profiles, :introduction, :text
  end
end
