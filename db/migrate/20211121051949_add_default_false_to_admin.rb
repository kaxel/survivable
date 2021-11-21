class AddDefaultFalseToAdmin < ActiveRecord::Migration[6.1]
  def change
    
    change_column_default :users, :admin, nil
    
  end
end
