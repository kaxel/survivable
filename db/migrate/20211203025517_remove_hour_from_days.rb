class RemoveHourFromDays < ActiveRecord::Migration[6.1]
  def change
    remove_column :days, :hour, :integer
  end
end
