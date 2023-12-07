class Day07
  def initialize(input, jokers = false)
    @games = parse_input(input)
    @jokers = jokers
  end

  def ranked_hands
    @games.map { |g| Hand.new(g[:hand], @jokers) }.sort.map(&:cards)
  end

  def total_winnings
    ranked_hands
      .each_with_index
      .reduce(0) do |acc, (hand, index)|
        game = @games.select { |g| g[:hand] == hand }.first

        acc += game[:bid] * (index + 1)
      end
  end

  private

  def parse_input(input)
    input
      .split("\n")
      .map do |line|
        hand, bid = line.scan(/(.{5}) (\d+)/).flatten

        { hand:, bid: bid.to_i }
      end
  end
end

class Hand
  CARD_VALUES = %w[2 3 4 5 6 7 8 9 T J Q K A]
  CARD_VALUES_JOKERS = %w[J 2 3 4 5 6 7 8 9 T Q K A]

  TYPES = %i[
    high_card
    one_pair
    two_pair
    three_kind
    full_house
    four_kind
    five_kind
  ]

  class MissingHandTypeError < StandardError
  end

  def initialize(cards, jokers = false)
    @cards = cards
    @jokers = jokers
  end

  attr_reader :cards

  def <=>(other)
    comparison = TYPES.index(self.type) <=> TYPES.index(other.type)

    return comparison unless comparison.zero?

    card_comparison = 0
    self.cards.chars.each_with_index do |self_card, i|
      if (card_comparison = compare_cards(self_card, other.cards.chars[i])) != 0
        break
      end
    end

    card_comparison
  end

  def compare_cards(first, second)
    values = @jokers ? CARD_VALUES_JOKERS : CARD_VALUES

    values.index(first) <=> values.index(second)
  end

  def type
    case true
    when high_card?
      :high_card
    when one_pair?
      :one_pair
    when two_pair?
      :two_pair
    when three_kind?
      :three_kind
    when full_house?
      :full_house
    when four_kind?
      :four_kind
    when five_kind?
      :five_kind
    else
      fail MissingHandTypeError.new(
             "No matching hand type for a hand of \"#{cards}\"!"
           )
    end
  end

  def high_card?
    unique_card_set.count == 5
  end

  def pairs
    unique_card_count.select { |n| n == 2 }
  end

  def one_pair?
    pairs.count == 1 && three_kinds.empty?
  end

  def two_pair?
    pairs.count == 2
  end

  def three_kinds
    unique_card_count.select { |n| n == 3 }
  end

  def three_kind?
    three_kinds.any? && pairs.empty?
  end

  def full_house?
    pairs.any? && unique_card_count.select { |n| n == 2 || n == 3 }.count == 2
  end

  def four_kind?
    unique_card_count.select { |n| n == 4 }.any?
  end

  def five_kind?
    unique_card_count.first == 5
  end

  private

  def cards_in_hand
    cards_in_hand ||= @jokers ? wild_cards : cards
  end

  def unique_card_set
    return @unique_card_set if defined?(@unique_card_set)

    @unique_card_set = cards_in_hand.chars.to_a.uniq
  end

  def wild_cards
    return cards unless /J/.match?(cards)

    card, count = cards.gsub(/J/, "").each_char.tally.max_by { |_, v| v }

    count.nil? ? "AAAAA" : cards.gsub(/J/, card)
  end

  def unique_card_count
    return @unique_card_count if defined?(@unique_card_count)

    @unique_card_count =
      unique_card_set.map { |card| cards_in_hand.scan(/#{card}/).count }
  end
end
