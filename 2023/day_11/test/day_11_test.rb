require_relative "../../test_helper"
require_relative "../day_11"

class Day11Test < Minitest::Test
  INPUT = <<~INPUT
...#......
.......#..
#.........
..........
......#...
.#........
.........#
..........
.......#..
#...#.....
  INPUT

  test "wat it do" do
    assert_equal 374, Day11.new(INPUT).sum_of_all_shortest_paths
  end
end