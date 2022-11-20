class AddDevelopmentIncomesToGameState < ActiveRecord::Migration[7.0]
  def change
    change_column_default :games, :state, from: GameMap::MAP_DATA_V3, to: GameMap::MAP_DATA_V4
  end
end
