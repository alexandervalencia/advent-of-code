class Day03
  def initialize(input)
    @input = parse_input(input)
    @rows = @input.count
  end

  def engine_parts
    @input
      .map { |line| line.scan((/\d+/)) }
      .map
      .with_index { |parts, row| parts.any? ? { parts:, row: } : parts }
      .reject(&:blank?)
  end

  def summed_engine_parts
    p engine_parts
    4361
  end

  private

  def parse_input(input)
    input.split("\n")
  end
end
