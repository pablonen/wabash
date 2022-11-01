class Game < ApplicationRecord
  HEX_H = 18
  HEX_W = 15
  MAP_COLS = 2
  MAP_ROWS = 2

  HEX_DATA = {}
  COL_ALPHA = (('A'.ord)..('A'.ord+MAP_COLS)).map(&:chr)
end
