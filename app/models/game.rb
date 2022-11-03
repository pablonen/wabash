class Game < ApplicationRecord
  HEX_H = 18
  HEX_W = 15
  MAP_COLS = 2
  MAP_ROWS = 2

  HEX_DATA = {}
  COL_ALPHA = (('A'.ord)..('A'.ord+MAP_COLS)).map(&:chr)

  after_create :init_hex_state

  def init_hex_state
    initial_state = {}
    initial_state[:hexes] = {}
    coord_enumerator do |coord|
      initial_state[:hexes][coord.to_s] = {}
    end
    state = initial_state
    save
  end

  def built?(hex)
    return false unless state["hexes"][hex]["built"]
    true
  end

  def build_cost(hex)
    state["hexes"][hex]["cost"] || 0
  end

  def coordinate(i,j)
    COL_ALPHA[i]+j.to_s
  end

  def hex_type(hex)
    state["hexes"][hex]["type"] || "undefined"
  end

  def grid_enumerator
    (HEX_W..HEX_W*MAP_COLS).step(HEX_W).each_with_index do |x, i|
      (HEX_H..HEX_H*MAP_ROWS).step(HEX_H).each_with_index do |y, j|
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
      (0..MAP_ROWS).each do |row|
        yield col+row.to_s
      end
    end
  end
end
