class AddStartedToGames < ActiveRecord::Migration[7.0]
  def change
    add_column :games, :started, :timestamp, default: nil 
    add_reference :games, :user, null: false, foreign_key: true
  end
end
