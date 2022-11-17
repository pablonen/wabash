class AddIncomesToMap < ActiveRecord::Migration[7.0]
  def change
    change_column_default :games, :state, from: GameMap::MAP_WITH_COMPANIES, to: GameMap::MAP_DATA_V3
  end
end
