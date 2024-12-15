class Day04
  XMAS = "XMAS".freeze
  STEPS = XMAS.size - 1

  TRAVERSE = {
    WEST_EAST: [0, STEPS],
    EAST_WEST: [0, -STEPS],
    SOUTH: [STEPS, 0],
    NORTH: [-STEPS, 0],
    NW_SE: [STEPS, STEPS],
    SW_NE: [-STEPS, STEPS],
    NE_SW: [STEPS, -STEPS],
    SE_NW: [-STEPS, -STEPS]
  }

  MAS = "MAS".freeze
  MAS_STEPS = MAS.size - 1

  MAS_TRAVERSE = {
    NW_SE: [MAS_STEPS, MAS_STEPS],
    SW_NE: [-MAS_STEPS, MAS_STEPS],
    NE_SW: [MAS_STEPS, -MAS_STEPS],
    SE_NW: [-MAS_STEPS, -MAS_STEPS]
  }

  def initialize(input, x_mas: false)
    @input = parse_input(input)
    @x_mas = x_mas
  end

  attr_reader :input, :x_mas

  def call
    count = 0

    input.each_with_index do |row, x|
      row.each_with_index do |letter, y|
        if letter == "M" && x_mas
          MAS_TRAVERSE.each do |(direction)|
            next unless can_traverse?(input, x, y, direction)

            count += 1 if x_mas_found?(input, x, y, direction)
          end
        elsif letter == XMAS[0] && !x_mas
          TRAVERSE.each do |(direction)|
            next unless can_traverse?(input, x, y, direction)

            count += 1 if xmas_found?(input, x, y, direction)
          end
        end
      end
    end

    count
  end

  # private

  def xmas_found?(grid, x_start, y_start, direction)
    found = false
    x = x_start
    y = y_start
    x_traverse, y_traverse = TRAVERSE[direction]
    word = ""

    XMAS.each_char do |char|
      word += grid[x][y]

      if grid[x][y] != char || found
        word = ""
        break
      end

      if word == XMAS
        found = true
        break
      end

      x += x_traverse.positive? ? 1 : x_traverse.negative? ? -1 : 0
      y += y_traverse.positive? ? 1 : y_traverse.negative? ? -1 : 0
    end

    found
  end

  def x_mas_found?(grid, x_start, y_start, direction)
    first_mas_found = mas_found?(grid, x_start, y_start, direction)
    return false unless first_mas_found

    first_a_loc = get_a_loc(grid, x_start, y_start, direction)
    second_mas_found = false
    second_a_loc = get_a_loc(grid, x_start, y_start, direction)

    [[0, 2], [2, 0]].each do |(x_step, y_step)|
      next_x = x_start + x_step
      next_y = y_start + y_step
      next_dir = get_criss_cross_dir(x_step, y_step, direction)

      if grid[next_x][next_y] == MAS[0]
        second_mas_found = mas_found?(grid, next_x, next_y, next_dir)
      end
    end

    first_mas_found && second_mas_found && first_a_loc == second_a_loc
  end

  def get_criss_cross_dir(x, y, direction)
    criss_cross_dict = {
      "[0, 2]" => {
        NW_SE: :NE_SW,
        SW_NE: :SE_NW
      },
      "[2, 0]" => {
        NW_SE: :SW_NE,
        NE_SW: :SE_NW
      }
    }
    pp("#{[x, y]}, #{criss_cross_dict[[x, y].to_s]}, #{direction}")
    return criss_cross_dict[[x, y].to_s][direction]
  end

  def get_a_loc(grid, x_start, y_start, direction)
    x_traverse, y_traverse = MAS_TRAVERSE[direction]
    x_step = x_traverse.positive? ? 1 : x_traverse.negative? ? -1 : 0
    y_step = y_traverse.positive? ? 1 : y_traverse.negative? ? -1 : 0

    [x_start + x_step, y_start + y_step]
  end

  def mas_found?(grid, x_start, y_start, direction)
    found = false
    x = x_start
    y = y_start

    x_traverse, y_traverse = MAS_TRAVERSE[direction]
    word = ""

    MAS.each_char do |char|
      break if grid[x][y].nil?

      word = word + grid[x][y]

      if grid[x][y] != char || found
        word = ""
        break
      end

      if word == MAS
        found = true
        break
      end

      x += x_traverse.positive? ? 1 : x_traverse.negative? ? -1 : 0
      y += y_traverse.positive? ? 1 : y_traverse.negative? ? -1 : 0
    end

    found
  end

  def can_traverse?(grid, x, y, direction)
    x_steps = x_mas ? MAS_TRAVERSE[direction][0] : TRAVERSE[direction][0]
    y_steps = x_mas ? MAS_TRAVERSE[direction][1] : TRAVERSE[direction][1]

    within_x_bounds = x + x_steps >= 0 && x + x_steps <= (grid.size - 1)
    within_y_bounds =
      y + y_steps >= 0 && y + y_steps <= (grid.transpose.size - 1)

    within_x_bounds && within_y_bounds
  end

  def parse_input(input)
    input.split("\n").map { |line| line.split("") }
  end
end
