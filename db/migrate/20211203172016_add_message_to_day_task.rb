class AddMessageToDayTask < ActiveRecord::Migration[6.1]
  def change
    add_column :day_tasks, :message, :string
  end
end
