class AddIncomeRangeToAnnualIncomeMst < ActiveRecord::Migration[6.0]
  def change
    remove_column :annual_income_msts, :amount_or_more, :integer
    add_column :annual_income_msts, :income_range, :string
  end
end
