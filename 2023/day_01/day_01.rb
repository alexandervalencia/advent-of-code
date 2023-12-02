class CalibrationMachine
  def initialize(input, convert_words = false)
    @input = parse_input(input, convert_words)
  end

  def run
    extracted_nums = @input.map { |str| extract_nums(str) }
    calibration_pairs =
      extracted_nums.map { |nums| [nums.first, nums.last].join("") }
    integerized_nums = calibration_pairs.map(&:to_i)

    integerized_nums.sum
  end

  private

  def extract_nums(str)
    str.scan(/\d/)
  end

  def parse_input(input, convert_words)
    parsed = input.split("\n")

    (convert_words) ? parsed.map { |line| convert_to_numerals(line) } : parsed
  end

  def convert_to_numerals(input)
    num_words = %w[zero one two three four five six seven eight nine]
    num_regex = /(?=(\d|zero|one|two|three|four|five|six|seven|eight|nine))/
    input
      .scan(num_regex)
      .flatten
      .map { |num| num_words.include?(num) ? num_words.index(num).to_s : num }
      .join("")
  end
end
