class Game < ApplicationRecord
  HEX_H = 18
  HEX_W = 15
  MAP_COLS = 2
  MAP_ROWS = 2

  HEX_DATA = {}
  COL_ALPHA = (('A'.ord)..('A'.ord+MAP_COLS)).map(&:chr)

  def grid_enumerator
    (HEX_W..HEX_W*MAP_COLS).step(HEX_W).each_with_index do |x, i|
      (HEX_H..HEX_H*MAP_ROWS).step(HEX_H).each_with_index do |y, j|
        yield x,y,i,j
      end
    end
  end
end
