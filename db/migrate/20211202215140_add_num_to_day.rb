class AddNumToDay < ActiveRecord::Migration[6.1]
  def change
    add_column :days, :num, :integer, limit: 2
  end
end
