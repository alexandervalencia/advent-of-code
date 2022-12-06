input = File.read("input.txt").split("\n\n").map { |line| line.split("\n").map(&:to_i) }
example = File.read("example.txt").split("\n\n").map { |line| line.split("\n").map(&:to_i) } # [[1000, 2000, 3000], [4000], [5000, 6000], [7000, 8000, 9000], [10_000]]

class CalorieHolders
  def initialize(calorie_holders)
    @calorie_holders = calorie_holders
  end

  def find_maximum
    sum_holders.max
  end

  def top_three_total
    first, second, third = sum_holders.sort.reverse
    first + second + third
  end

  private

  attr_reader :calorie_holders

  def sum_holders
    calorie_holders.map(&:sum)
  end
end

p CalorieHolders.new(example).find_maximum # 24000
p CalorieHolders.new(input).find_maximum # 68775
p CalorieHolders.new(example).top_three_total # 45000
p CalorieHolders.new(input).top_three_total # 202585
