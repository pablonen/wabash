class ChangeStateColumnDefault < ActiveRecord::Migration[7.0]
  def change
    change_column_null :games, :state, false
    change_column_default :games, :state, '{}'
    
    add_index :games, :state, using: :gin
  end
end
