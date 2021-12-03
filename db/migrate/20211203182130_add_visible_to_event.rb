class AddVisibleToEvent < ActiveRecord::Migration[6.1]
  def change
    add_column :events, :visible, :boolean, default: true
  end
end
