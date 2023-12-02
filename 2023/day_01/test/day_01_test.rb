require_relative "../../test_helper"
require_relative "../day_01"

class Day01Test < Minitest::Test
  EXAMPLE_INPUT = <<~INPUT
1abc2
pqr3stu8vwx
a1b2c3d4e5f
treb7uchet
  INPUT

  EXAMPLE_INPUT_TWO = <<~INPUT
two1nine
eightwothree
abcone2threexyz
xtwone3four
4nineeightseven2
zoneight234
7pqrstsixteen
  INPUT

  test "example" do
    assert_equal 142, CalibrationMachine.new(EXAMPLE_INPUT).run
  end

  test "spelled out letters" do
    assert_equal 281, CalibrationMachine.new(EXAMPLE_INPUT_TWO, true).run
  end
end
