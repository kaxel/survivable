class AddUserToSurvivalists < ActiveRecord::Migration[6.1]
  def change
    add_reference :survivalists, :user, null: false, foreign_key: true
  end
end
