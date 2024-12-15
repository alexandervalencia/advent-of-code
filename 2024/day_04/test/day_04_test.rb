require_relative "../../test_helper"
require_relative "../day_04"

class Day04Test < Minitest::Test
  EXAMPLE_INPUT = <<~INPUT
MMMSXXMASM
MSAMXMSMSA
AMXSXMAAMM
MSAMASMSMX
XMASAMXAMM
XXAMMXXAMA
SMSMSASXSS
SAXAMASAAA
MAMMMXMMMM
MXMXAXMASX
INPUT

  def test_example_one
    assert_equal 18, Day04.new(EXAMPLE_INPUT).call
  end

  def test_xmas_found?
    subject = Day04.new(EXAMPLE_INPUT)
    grid = [%w[X M A S], *Array.new(3).map { Array.new(4).map { "O" } }]

    assert subject.xmas_found?(grid, 0, 0, :WEST_EAST)
    refute subject.xmas_found?(grid, 0, 3, :EAST_WEST)

    grid = [%w[S A M X], *Array.new(3)]
    assert subject.xmas_found?(grid, 0, 3, :EAST_WEST)
    refute subject.xmas_found?(grid, 0, 2, :WEST_EAST)
  end

  def test_mas_found?
    subject = Day04.new(EXAMPLE_INPUT)
    grid = [%w[M O O], %w[O A O], %w[O O S]]

    assert subject.mas_found?(grid, 0, 0, :NW_SE)

    grid = [%w[O O S], %w[O A O], %w[M O O]]

    assert subject.mas_found?(grid, 2, 0, :SW_NE)

    grid = [%w[M M M], %w[M A M], %w[M M M]]

    refute subject.mas_found?(grid, 0, 0, :NW_SE)
  end

  def test_x_mas_found?
    subject = Day04.new(EXAMPLE_INPUT)
    grid = [%w[M O M], %w[O A O], %w[S O S]]

    assert subject.x_mas_found?(grid, 0, 0, :NW_SE)
  end

  def test_can_traverse?
    subject = Day04.new(EXAMPLE_INPUT)
    grid = Array.new(4).map { Array.new(4) }

    assert subject.can_traverse?(grid, 0, 0, :WEST_EAST)
    refute subject.can_traverse?(grid, 0, 3, :WEST_EAST)

    assert subject.can_traverse?(grid, 0, 3, :EAST_WEST)
    refute subject.can_traverse?(grid, 0, 0, :EAST_WEST)

    assert subject.can_traverse?(grid, 0, 0, :SOUTH)
    refute subject.can_traverse?(grid, 3, 0, :SOUTH)

    assert subject.can_traverse?(grid, 3, 0, :NORTH)
    refute subject.can_traverse?(grid, 0, 0, :NORTH)

    assert subject.can_traverse?(grid, 0, 0, :NW_SE)
    refute subject.can_traverse?(grid, 1, 1, :NW_SE)

    assert subject.can_traverse?(grid, 0, 3, :NE_SW)
    refute subject.can_traverse?(grid, 0, 2, :NE_SW)

    assert subject.can_traverse?(grid, 3, 3, :SE_NW)
    refute subject.can_traverse?(grid, 2, 2, :SE_NW)

    assert subject.can_traverse?(grid, 3, 0, :SW_NE)
    refute subject.can_traverse?(grid, 2, 0, :SW_NE)
  end

  focus
  def test_example_two
    assert_equal 9, Day04.new(EXAMPLE_INPUT, x_mas: true).call
  end
end
