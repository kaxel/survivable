class AddQuantityToPossessions < ActiveRecord::Migration[6.1]
  def change
    add_column :possessions, :quantity, :integer, limit: 2, default: 1
  end
end
