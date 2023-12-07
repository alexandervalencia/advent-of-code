require_relative "../../test_helper"
require_relative "../day_03"

class Day03Test < Minitest::Test
  input = <<~INPUT
467..114..
...*......
..35..633.
......#...
617*......
.....+.58.
..592.....
......755.
...$.*....
.664.598..
  INPUT

  test "wat it do" do
    subject = described_class.new(input)

    assert_equal 4361, subject.summed_engine_parts
  end
end
