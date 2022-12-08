require_relative "../../test_helper"
require_relative "../day_08"

class Day08Test < Minitest::Test
  def input
    <<~INPUT
      30373
      25512
      65332
      33549
      35390
    INPUT
  end

  test "Example Part 1" do
    assert_equal 21, TreeHouse.new(input).visible_trees
  end

  test "Example Part 3" do
    assert_equal 8, TreeHouse.new(input).highest_scenic_score
  end
end
