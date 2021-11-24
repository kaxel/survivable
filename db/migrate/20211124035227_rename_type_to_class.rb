class RenameTypeToClass < ActiveRecord::Migration[6.1]
  def change
    rename_column :animals, :type, :class
  end
end
