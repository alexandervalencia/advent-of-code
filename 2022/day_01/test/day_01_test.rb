require_relative "../../test_helper"
require_relative "../day_01"

class Day01Test < Minitest::Test
  input = File.read("../example.txt").split("\n\n").map { |line| line.split("\n").map(&:to_i) }

  test "Part 1 - example" do
    assert_equal 24_000, CalorieHolders.new(input)
  end
end
