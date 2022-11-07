class Game < ApplicationRecord
  HEX_H = 18
  HEX_W = 15
  MAP_COLS = 19
  MAP_ROWS = 11

  HEX_DATA = {}
  COL_ALPHA = ('A'..'S').to_a

  def built?(hex)
    return false unless state.dig("hexes", hex, "built")
    true
  end

  def build_cost(hex)
    state["hexes"].dig(hex, "cost") || 0
  end

  def coordinate(i,j)
    COL_ALPHA[i]+j.to_s
  end

  def hex_type(hex)
    state["hexes"].dig(hex, "type") || "undefined" 
  end

  def grid_enumerator
    (HEX_W..HEX_W*MAP_COLS).step(HEX_W).each_with_index do |x, i|
      (HEX_H..HEX_H*MAP_ROWS).step(HEX_H).each_with_index do |y, j|
        next unless state["hexes"][coordinate(i,j)]
        if i % 2 == 1
          y = y + HEX_H / 2
        end
        hex_id = coordinate(i,j)
        hex_built = built?(hex_id)
        hex_build_cost = build_cost(hex_id)
        hex_type = hex_type(hex_id)

        yield Hex.new(x,y,i,j,hex_id,hex_type,hex_build_cost, hex_built)
      end
    end
  end

  def coord_enumerator
    COL_ALPHA.each do |col|
      GameMap::TYPE_BY_COLUMN[col].each_with_index do |type, i|
        yield col+i.to_s, type
      end
    end
  end
end
