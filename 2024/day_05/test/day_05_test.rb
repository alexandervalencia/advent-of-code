require_relative "../../test_helper"
require_relative "../day_05"

class Day05Test < Minitest::Test
  EXAMPLE_INPUT = <<~INPUT
47|53
97|13
97|61
97|47
75|29
61|13
75|53
29|13
97|29
53|29
61|53
97|53
61|29
47|13
75|47
97|75
47|61
75|61
47|29
75|13
53|13

75,47,61,53,29
97,61,53,29,13
75,29,13
75,97,47,61,53
61,13,29
97,13,75,29,47
  INPUT

  def test_example_one
    assert_equal 143, Day05.new(EXAMPLE_INPUT).call
  end

  def test_example_twos
    assert_equal 123, Day05.new(EXAMPLE_INPUT, fix_incorrect: true).call
  end

  def test_build_rule_string
    test_input = <<~INPUT
10|20
10|15
20|40
40|30
10|30
15|20

10,20,15,40,30
    INPUT
    assert_equal "10,15,20,40,30",
                 Day05.new(EXAMPLE_INPUT, fix_incorrect: true).build_rule_string
  end

  def test_correct_order?
    test_input = <<~INPUT
10|20
10|15
40|30
10|30

10,20,15,40,30
    INPUT
    subject = Day05.new(test_input)

    assert subject.correct_order?(%w[10 20 15 40 30])

    refute subject.correct_order?(%w[20 10 15 40 30])
  end
end
