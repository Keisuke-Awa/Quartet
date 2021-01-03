class AddColumnToAnnualIncomeMst < ActiveRecord::Migration[6.0]
  def change
    add_column :annual_income_msts, :amount_or_more, :integer
    add_column :annual_income_msts, :less_than_amount, :integer
  end
end
