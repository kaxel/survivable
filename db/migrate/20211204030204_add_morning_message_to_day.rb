class AddMorningMessageToDay < ActiveRecord::Migration[6.1]
  def change
    add_column :days, :morning_message, :string
  end
end
