require_relative "../../test_helper"
require_relative "../day_03"

class Day03Test < Minitest::Test
  EXAMPLE_INPUT =
    "xmul(2,4)%&mul[3,7]!@^do_not_mul(5,5)+mul(32,64]then(mul(11,8)mul(8,5))"

  EXAMPLE_TWO =
    "xmul(2,4)&mul[3,7]!^don't()_mul(5,5)+mul(32,64](mul(11,8)undo()?mul(8,5))"

  def test_example_one
    assert_equal 161, Day03.new(EXAMPLE_INPUT).call
  end

  def test_example_two
    assert_equal 48, Day03.new(EXAMPLE_TWO, handle_instructions: true).call
  end
end
