class AddHiddenToEvents < ActiveRecord::Migration[6.1]
  def change
    add_column :events, :hidden, :boolean, :default => false
  end
end
