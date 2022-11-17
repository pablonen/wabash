# Handle hexmap pathfinding &c.
module HexPathfinding

  AxialHex = Struct.new(:q, :r)
  OffsetHex = Struct.new(:column, :row)

  AXIAL_DIRECTION_VECTORS = [AxialHex.new(1,0),
                             AxialHex.new(1,-1),
                             AxialHex.new(0,-1),
                             AxialHex.new(-1,0),
                             AxialHex.new(-1,1),
                             AxialHex.new(0,+1)]

  def self.neighbours(axial_hex)
    AXIAL_DIRECTION_VECTORS.map do |direction|
      AxialHex.new(axial_hex.q + direction.q, axial_hex.r + direction.r)
    end
  end

  def self.destructure_hex_coordinate(hex)
    components = /(\D+)(\d+)/.match(hex).captures
    column = components[0].ord - 'A'.ord
    row = components[1].to_i
    OffsetHex.new(column, row)
  end

  def self.oddq_to_axial(offset_hex)
    q = offset_hex.column
    r = offset_hex.row - ( offset_hex.column - (offset_hex.column & 1)) / 2
    AxialHex.new(q, r)
  end
end
