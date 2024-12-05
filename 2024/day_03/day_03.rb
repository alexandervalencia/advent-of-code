class Day03
  SIMPLE_MULT_REGEX = /(mul\((\d{1,3}),(\d{1,3})\))/
  INSTRUCTIVE_MULT_REGEX = /(mul\((\d{1,3}),(\d{1,3})\))|(do\(\))|(don't\(\))/

  def initialize(input, handle_instructions: false)
    @input = parse_input(input)
    @handle_instructions = handle_instructions
  end

  attr_reader :input, :handle_instructions

  def call
    enabled = true
    regex = handle_instructions ? INSTRUCTIVE_MULT_REGEX : SIMPLE_MULT_REGEX

    input
      .scan(regex)
      .reduce(0) do |memo, (match, a, b, start, stop)|
        if match
          memo += a.to_i * b.to_i if enabled
        elsif start
          enabled = true
        elsif stop
          enabled = false
        end

        (enabled = !!start || !!stop) if handle_instructions

        memo
      end
  end

  private

  def parse_input(input)
    input.split("\n").join("")
  end
end
