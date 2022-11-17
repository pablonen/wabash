require "test_helper"

class HexPathfindingTest < ActiveSupport::TestCase

  setup do
    @hex_a = HexPathfinding::AxialHex.new(0,0)
    @hex_b = HexPathfinding::AxialHex.new(5,1)
  end

  test "destructure_hex_coordinate" do
    destructured = HexPathfinding.destructure_hex_coordinate('A0')
    assert destructured.row == 0
    assert destructured.column == 0

    destructured = HexPathfinding.destructure_hex_coordinate('A1')
    assert destructured.row == 1
    assert destructured.column == 0

    dest = HexPathfinding.destructure_hex_coordinate('C2')
    assert dest.row == 2
    assert dest.column == 2
  end

  test "neighbours" do
    hex = HexPathfinding::AxialHex.new(2,2)
    neighbours = HexPathfinding.neighbours(hex)

    expected_neighbours = [[3,2],[3,1],[2,1],[1,2],[1,3],[2,3]]
    expected_neighbours.map! do |(q,r)|
      HexPathfinding::AxialHex.new(q,r)
    end
    expected_neighbours.each do |en|
      assert neighbours.include?(en)
    end

    assert neighbours.size == 6
  end
end
