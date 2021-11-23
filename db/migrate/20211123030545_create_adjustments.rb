class CreateAdjustments < ActiveRecord::Migration[6.1]
  def change
    create_table :adjustments do |t|
      t.string :bonus
      t.integer :amount, limit: 2
      t.references :project, null: false, foreign_key: true

      t.timestamps
    end
  end
end
