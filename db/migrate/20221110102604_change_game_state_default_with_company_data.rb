class ChangeGameStateDefaultWithCompanyData < ActiveRecord::Migration[7.0]
  def change
    change_column_default :games, :state, from: GameMap::MAP_DATA , to: GameMap::MAP_WITH_COMPANIES
  end
end
