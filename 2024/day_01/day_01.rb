class Day01
  def initialize(input)
    @input = parse_input(input)
  end

  def total_distance
    left, right = @input.each { |list| list.sort! }
    left
      .each_with_index
      .reduce(0) { |memo, (loc_id, idx)| memo + diff(loc_id, right[idx]) }
  end

  def similarity_score
    left, right = @input
    tally = right.tally
    left.reduce(0) do |memo, loc_id|
      mult = tally.dig(loc_id) || 0
      memo + (loc_id * mult)
    end
  end

  private

  def diff(a, b)
    (a - b).abs
  end

  def parse_input(input)
    input
      .split("\n")
      .reduce([[], []]) do |memo, line|
        l, r = line.split("   ")
        memo[0] << l.to_i
        memo[1] << r.to_i
        memo
      end
  end
end
