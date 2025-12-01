class Day05
  def initialize(input, fix_incorrect: false)
    parsed_input = parse_input(input)
    @order_rules, @updates = parsed_input
    @fix_incorrect = fix_incorrect
  end

  attr_reader :fix_incorrect, :order_rules, :updates

  def call
    correct_updates, incorrect_updates = sorted_updates

    return corrected(incorrect_updates) if fix_incorrect

    correct_updates.map { |list| middle(list.map(&:to_i)) }.flatten.sum
  end

  def correct_order?(arr)
    correct_order = true
    order_rules.each do |rule|
      break if !correct_order
      next unless (arr & rule).length > 1
      a, b = rule

      correct_order = /#{a}.+#{b}/.match?(arr.join(","))
    end

    correct_order
  end

  def build_rule_string
  end

  private

  def corrected(incorrect_updates)
    incorrect_updates.each do |update|
      broken = true
      relevant_rules =
        order_rules.select { |rule| rule.all? { |n| update.include?(n) } }

      while broken
        broken_rules =
          relevant_rules.reject do |(a, b)|
            /#{a}.+#{b}/.match?(update.join(","))
          end

        broken_rules.each do |(a, b)|
          update =
            update.insert(update.index(b), update.delete_at(update.index(a)))
        end

        broken = !correct_order?(update)
      end
    end
    123
  end

  def sorted_updates
    [[], []].tap do |correct, incorrect|
      updates.each do |update|
        correct_order?(update) ? correct << update : incorrect << update
      end
    end
  end

  def middle(s)
    a, b = (s.length - 1).divmod(2)
    s[a, b + 1]
  end

  def parse_input(input)
    input
      .split("\n\n")
      .map do |line|
        line
          .split("\n")
          .map { |i| i.include?("|") ? i.split("|") : i.split(",") }
      end
  end
end
