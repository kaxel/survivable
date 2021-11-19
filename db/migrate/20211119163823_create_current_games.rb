class CreateCurrentGames < ActiveRecord::Migration[6.1]
  def change
    create_table :current_games do |t|
      t.string :sig
      t.string :ip

      t.timestamps
    end
  end
end
