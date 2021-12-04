class AddVisibleToStash < ActiveRecord::Migration[6.1]
  def change
    add_column :stashes, :visible, :boolean, :default => true
  end
end
