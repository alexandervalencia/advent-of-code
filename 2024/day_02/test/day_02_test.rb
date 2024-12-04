require_relative "../../test_helper"
require_relative "../day_02"

class Day02Test < Minitest::Test
  EXAMPLE_INPUT = <<~INPUT
7 6 4 2 1
1 2 7 8 9
9 7 6 2 1
1 3 2 4 5
8 6 4 4 1
1 3 6 7 9
  INPUT

  def test_remove_one_unsafe_distance
    assert_equal [1, 2, 3, 4],
                 Day02.new(EXAMPLE_INPUT).send(
                   :remove_one_unsafe_distance,
                   [1, 2, 3, 3, 4]
                 )

    assert_equal [1, 2, 3, 4],
                 Day02.new(EXAMPLE_INPUT).send(
                   :remove_one_unsafe_distance,
                   [1, 5, 2, 3, 4]
                 )

    assert_equal [1, 2, 3, 4],
                 Day02.new(EXAMPLE_INPUT).send(
                   :remove_one_unsafe_distance,
                   [1, 2, 3, 4, 10]
                 )

    assert_equal [1, 2, 3, 4],
                 Day02.new(EXAMPLE_INPUT).send(
                   :remove_one_unsafe_distance,
                   [1, 3, 2, 3, 4]
                 )
  end

  def test_example_safe_reports
    assert_equal 2, Day02.new(EXAMPLE_INPUT).safe_reports
  end

  def test_example_safe_reports_with_dampener
    assert_equal 4,
                 Day02.new(EXAMPLE_INPUT, problem_dampener: true).safe_reports
  end

  def test_ascending?
    assert Day02.new(EXAMPLE_INPUT).send(:ascending?, [1, 2, 7, 8, 9])
    refute Day02.new(EXAMPLE_INPUT).send(:ascending?, [1, 2, 7, 8, 8])
    refute Day02.new(EXAMPLE_INPUT).send(:ascending?, [9, 8, 7, 2, 1])
  end

  def test_descending?
    assert Day02.new(EXAMPLE_INPUT).send(:descending?, [9, 8, 7, 2, 1])
    refute Day02.new(EXAMPLE_INPUT).send(:descending?, [1, 2, 2, 8, 9])
    refute Day02.new(EXAMPLE_INPUT).send(:descending?, [1, 2, 7, 8, 9])
  end
end
