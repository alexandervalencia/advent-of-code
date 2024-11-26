class Day03
  def initialize(input)
    @input = parse_input(input)
    @rows = @input.count
  end

  def schematic_numbers
    @input
      .map { |line| line.scan((/\d+/)) }
      .map
      .with_index { |parts, row| parts.any? ? { parts:, row: } : parts }
      .reject(&:empty?)
  end

  def get_surrounding_location(schematic)
    last_column_index = @input.first.size - 1

    schematic[:parts].map do |part|
      row_lower_boundary = [schematic[:row] - 1, 0].max
      row_upper_boundary = [schematic[:row] + 1, @input.size - 1].min
      part_index = @input[schematic[:row]].index(part)
      column_start = [part_index - 1, 0].max
      column_end = [part_index + part.length, last_column_index].min
      row_range = row_lower_boundary..row_upper_boundary
      col_range = column_start..column_end

      { part:, row_range:, col_range: }
    end
  end

  def summed_engine_parts
    schematic_numbers
      .map { |schematic| get_surrounding_location(schematic) }
      .map { |parts| parts.map { |part| engine_parts(part) } }
      .flatten
      .select { |p| p[:is_part] }
      .map { |p| p[:part].to_i }
      .sum
  end

  def engine_parts(schematic)
    schematic[:row_range].each do |r|
      schematic[:col_range].each do |c|
        if (/[^.|\d]/.match?(@input[r][c]))
          schematic[:is_part] = true
          break
        else
          schematic[:is_part] = false
        end
      end

      break if schematic[:is_part]
    end

    schematic
  end

  private

  def parse_input(input)
    input.split("\n")
  end
end
