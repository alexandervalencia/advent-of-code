require_relative "../../test_helper"
require_relative "../day_01"

class Day01Test < Minitest::Test
  EXAMPLE_INPUT = <<~INPUT
3   4
4   3
2   5
1   3
3   9
3   3
  INPUT

  EXAMPLE_INPUT_TWO = <<~INPUT
fill me in
  INPUT

  def test_example_total_distance
    assert_equal 11, Day01.new(EXAMPLE_INPUT).total_distance
  end

  def test_eample_similarity_score
    assert_equal 31, Day01.new(EXAMPLE_INPUT).similarity_score
  end
end
