require_relative "../../test_helper"
require_relative "../day_06"

class Day06Test < Minitest::Test
  input = <<~INPUT
Time: 7 15 30
Distance: 9 40 200
    INPUT

  test "solution 1 (#multipled_ways_to_win)" do
    subject = described_class.new(input)

    assert_equal 288, subject.multipled_ways_to_win
  end

  test "solution 2 (trimmed#multipled_ways_to_win)" do
    subject = described_class.new(input, trim: true)

    assert_equal 71_503, subject.multipled_ways_to_win
  end

  test "#winning_strategy?" do
    subject = described_class.new(input)
    race_rules = { race_time: 7, distance_to_beat: 9 }
    losing_strategies = [
      race_rules.merge({ hold_time: 0 }),
      race_rules.merge({ hold_time: 1 }),
      race_rules.merge({ hold_time: 6 }),
      race_rules.merge({ hold_time: 7 })
    ]
    winning_strategies = [
      race_rules.merge({ hold_time: 2 }),
      race_rules.merge({ hold_time: 3 }),
      race_rules.merge({ hold_time: 4 }),
      race_rules.merge({ hold_time: 5 })
    ]

    winning_strategies.each { |s| assert subject.winning_strategy?(**s) }
    losing_strategies.each { |s| refute subject.winning_strategy?(**s) }
  end

  test "#devise_winning_range" do
    subject = described_class.new(input)
    race_rules = { race_time: 7, distance_to_beat: 9 }

    assert_equal [2, 3, 4, 5], subject.devise_winning_range(**race_rules)
  end
end
