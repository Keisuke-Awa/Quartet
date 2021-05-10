class ChangeColumnsAddNotnull < ActiveRecord::Migration[6.0]
  def change
    change_column_null :smoking_msts, :smoking_status, false
    change_column_null :occupation_msts, :occupation_name, false
    change_column_null :messages, :content, false
    change_column_null :meetings, :meet_at, false
    change_column_null :meetings, :people, false
    change_column_null :educational_bg_msts, :ebg_name, false
    change_column_null :annual_income_msts, :income_range, false
  end
end
