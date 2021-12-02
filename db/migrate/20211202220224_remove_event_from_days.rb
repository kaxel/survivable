class RemoveEventFromDays < ActiveRecord::Migration[6.1]
  def change
    remove_reference :days, :event, null: false, foreign_key: true
  end
end
