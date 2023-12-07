require_relative "../../test_helper"
require_relative "../day_07"

class Day07Test < Minitest::Test
  INPUT = <<~INPUT
32T3K 765
T55J5 684
KK677 28
KTJJT 220
QQQJA 483
  INPUT

  test "Solution — Part 1" do
    subject = described_class.new(INPUT)

    assert_equal 6440, subject.total_winnings
  end

  test "Solution — Part 2" do
    subject = described_class.new(INPUT, true)

    assert_equal 5905, subject.total_winnings
  end
end

class HandTest < Minitest::Test
  describe "Hand Types" do
    test "high card" do
      subject = Hand.new("23456")

      assert_equal :high_card, subject.type
    end

    test "one pair" do
      subject = Hand.new("A23A4")

      assert_equal :one_pair, subject.type
    end

    test "two pair" do
      subject = Hand.new("23432")

      assert_equal :two_pair, subject.type
    end

    test "three of a kind" do
      subject = Hand.new("TTT98")

      assert_equal :three_kind, subject.type
    end

    test "full house" do
      subject = Hand.new("23332")

      assert_equal :full_house, subject.type
    end

    test "four of a kind" do
      subject = Hand.new("AA8AA")

      assert_equal :four_kind, subject.type
    end

    test "five of a kind" do
      subject = Hand.new("AAAAA")

      assert_equal :five_kind, subject.type
    end
  end

  describe "Hand Type Comparisons (<=>)" do
    test "five of a kind beats four of a kind" do
      first_hand = Hand.new("AAAAA")
      second_hand = Hand.new("AA8AA")

      assert_equal 1, first_hand <=> second_hand
    end

    test "three of a kind loses to four of a kind" do
      first_hand = Hand.new("TTT98")
      second_hand = Hand.new("AA8AA")

      assert_equal -1, first_hand <=> second_hand
    end

    describe "when hand types are equal" do
      test "compare each card left to right to determine the winner" do
        first_hand = Hand.new("33332")
        second_hand = Hand.new("2AAAA")

        assert_equal 1, first_hand <=> second_hand

        third_hand = Hand.new("KKJJJ")
        fourth_hand = Hand.new("AAA22")

        assert_equal -1, third_hand <=> fourth_hand

        fifth_hand = Hand.new("KKA88")
        sixth_hand = Hand.new("JAAKK")

        assert_equal 1, fifth_hand <=> sixth_hand
      end
    end

    describe "With Jokers" do
      test "the best ~potential~ hand wins" do
        first_hand = Hand.new("33J3J", true)
        second_hand = Hand.new("2AAAA", true)

        assert_equal 1, first_hand <=> second_hand
      end
    end
  end

  describe "Js are Jokers" do
    test "Hands are upgraded to the best possible version" do
      assert_equal :five_kind, Hand.new("JAAAA", true).type
      assert_equal :five_kind, Hand.new("JJJJJ", true).type
      assert_equal :five_kind, Hand.new("JJJJA", true).type
      assert_equal :four_kind, Hand.new("T55J5", true).type
      assert_equal :four_kind, Hand.new("KTJJT", true).type
      assert_equal :four_kind, Hand.new("QQQJA", true).type
      assert_equal :full_house, Hand.new("KK6J6", true).type
      assert_equal :three_kind, Hand.new("KK6J3", true).type
      assert_equal :one_pair, Hand.new("KQJ95", true).type
    end

    test "Hands without Jokers remain unchanged" do
      assert_equal :one_pair, Hand.new("32T3K", true).type
      assert_equal :four_kind, Hand.new("QAAAA", true).type
    end
  end
end
