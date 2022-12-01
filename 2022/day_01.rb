input = File.read("day_01.txt").split("\n\n").map { |line| line.split("\n").map(&:to_i) }
example = File.read("day_01_example.txt").split("\n\n").map { |line| line.split("\n").map(&:to_i) } # [[1000, 2000, 3000], [4000], [5000, 6000], [7000, 8000, 9000], [10_000]]

class CalorieHolders
  attr_reader :calorie_holders

  def initialize(calorie_holders)
    @calorie_holders = calorie_holders
  end

  def find_maximum(holders = sum_holders)
    holders.max
  end

  def sum_holders(holders = calorie_holders)
    holders.map(&:sum)
  end

  def top_three_total
    mutable_holders = sum_holders(calorie_holders.dup)

    [].tap do |total|
        3.times do
          max_calories = find_maximum(mutable_holders)
          total << max_calories
          mutable_holders -= [max_calories]
        end
      end
      .sum
  end
end

p CalorieHolders.new(example).find_maximum # 24000

p CalorieHolders.new(input).find_maximum # 11156781

p CalorieHolders.new(example).top_three_total # 45000

p CalorieHolders.new(input).top_three_total # 45000
