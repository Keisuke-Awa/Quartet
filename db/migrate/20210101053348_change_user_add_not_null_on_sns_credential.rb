class ChangeUserAddNotNullOnSnsCredential < ActiveRecord::Migration[6.0]
  def change
    change_column_null :sns_credentials, :user_id, false
  end
end
