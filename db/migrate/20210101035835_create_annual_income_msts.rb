class CreateAnnualIncomeMsts < ActiveRecord::Migration[6.0]
  def change
    create_table :annual_income_msts do |t|
      t.integer :amount_or_more

      t.timestamps
    end
  end
end
