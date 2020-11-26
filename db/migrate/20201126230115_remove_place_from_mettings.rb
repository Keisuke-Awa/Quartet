class RemovePlaceFromMettings < ActiveRecord::Migration[6.0]
  def change
    remove_column :mettings, :place, :string
  end
end
