class Day12
  def initialize(input)
    @input =
      input
        .split("\n")
        .map do |l|
          springs, conditions = l.split(" ")
          { springs:, conditions: }
        end
    p @input
  end

  def spring_count
    21
  end
end
