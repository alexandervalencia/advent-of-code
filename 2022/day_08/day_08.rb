require "matrix"

class TreeHouse
  def initialize(input)
    @forest_map =
      Matrix[*input.split("\n").map { |row| row.split("").map(&:to_i) }]
  end

  def visible_trees
    seen_trees = trees_on_the_edge

    (forest_map.row_size - 1).times do |row_idx|
      next if row_idx == 0

      (forest_map.column_size - 1).times do |col_idx|
        next if col_idx == 0

        vertically_visible = visible_vertically?(col_idx, row_idx)
        seen_trees += 1 if vertically_visible

        next if vertically_visible

        horizontally_visible = visible_horizontally?(col_idx, row_idx)
        next unless horizontally_visible

        seen_trees += 1
      end
    end

    seen_trees
  end

  def highest_scenic_score
    max = 0

    (forest_map.row_size - 1).times do |row_idx|
      next if row_idx == 0

      (forest_map.column_size - 1).times do |col_idx|
        next if col_idx == 0

        scenic_score = measure_viewing_distance(col_idx, row_idx).reduce(&:*)
        max = scenic_score if max < scenic_score
      end
    end

    max
  end

  attr_reader :forest_map

  def measure_viewing_distance(x, y)
    up = measure_north_viewing_distance(x, y)
    down = measure_south_viewing_distance(x, y)
    left = measure_west_viewing_distance(x, y)
    right = measure_east_viewing_distance(x, y)

    [up, down, left, right]
  end

  def measure_east_viewing_distance(x, y)
    distance = 0
    row = forest_map.row(y).to_a
    current_tree = row[x]

    row[x + 1..-1].each do |t|
      distance += 1
      break if t >= current_tree
    end

    distance
  end

  def measure_north_viewing_distance(x, y)
    distance = 0
    col = forest_map.column(x).to_a
    current_tree = col[y]

    col.reverse[col.size - y..-1].each do |t|
      distance += 1
      break if t >= current_tree
    end

    distance
  end

  def measure_south_viewing_distance(x, y)
    distance = 0
    col = forest_map.column(x).to_a
    current_tree = col[y]

    col[y + 1..-1].each do |t|
      distance += 1
      break if t >= current_tree
    end

    distance
  end

  def measure_west_viewing_distance(x, y)
    distance = 0
    row = forest_map.row(y).to_a
    current_tree = row[x]

    row.reverse[row.size - x..-1].each do |t|
      distance += 1
      break if t >= current_tree
    end

    distance
  end

  private

  def trees_on_the_edge
    columns = forest_map.column_size
    rows = forest_map.row_size - 2

    (columns * 2) + (rows * 2)
  end

  def visible_vertically?(x, y)
    column = forest_map.column(x).to_a
    current_tree = column[y]
    south = column[y + 1..-1].all? { |n| n < current_tree }

    return south if south

    column.reverse[column.size - y..-1].all? { |n| n < current_tree }
  end

  def visible_horizontally?(x, y)
    row = forest_map.row(y).to_a
    current_tree = row[x]
    east = row[x + 1..-1].all? { |n| n < current_tree }

    return east if east

    row.reverse[row.size - x..-1].all? { |n| n < current_tree }
  end
end

def input
  <<~INPUT
      30373
      25512
      65332
      33549
      35390
    INPUT
end
