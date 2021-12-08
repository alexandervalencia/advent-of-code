require "minitest/autorun"

class TheTest < Minitest::Test
  def example_input
    <<~EXAMPLE_INPUT
      7,4,9,5,11,17,23,2,0,14,21,24,10,16,13,6,15,25,12,22,18,20,8,19,3,26,1

      22 13 17 11  0
       8  2 23  4 24
      21  9 14 16  7
       6 10  3 18  5
       1 12 20 15 19

       3 15  0  2 22
       9 18 13 17  5
      19  8  7 25 23
      20 11 10 24  4
      14 21 16 12  6

      14 21 17 24  4
      10 16 15  9 19
      18  8 23 26 20
      22 11 13  6  5
       2  0 12  3  7
    EXAMPLE_INPUT
  end

  def real_input
    File.read("./day_04.txt")
  end

  def test_part_one_example
    assert_equal 4512, BingoGame.new(example_input).play.winning_score
  end

  def test_part_one_solution
    assert_equal 39902, BingoGame.new(real_input).play.winning_score
  end

  def test_part_two_example
    assert_equal 1924, BingoGame.new(example_input).play_to_lose.winning_score
  end

  def test_part_two_solution
    assert_equal 26936, BingoGame.new(real_input).play_to_lose.winning_score
  end

  def test_horizontal_winner
    winning_row_bingo_board = <<~BOARD
      22 13 17 11  0
       X  X  X  X  X
      21  9 14 16  7
       6 10  3 18  5
       1 12 20 15 19
    BOARD
    assert BingoBoard.new(winning_row_bingo_board).winner?
  end

  def test_vertical_winner
    winning_col_bingo_board = <<~BOARD
      22  X 17 11  0
       8  X 23  4 24
      21  X 14 16  7
       6  X  3 18  5
       1  X 20 15 19
    BOARD
    assert BingoBoard.new(winning_col_bingo_board).winner?
  end

  def test_marked_but_not_five_in_a_row_loses
    losing_bingo_board_marked = <<~BOARD
       X 13  X 11  X
       8  X 23  X 24
      21  9  X  X  7
       X  X  X  X  5
       1 12  X 15 19
    BOARD
    refute BingoBoard.new(losing_bingo_board_marked).winner?
  end

  def test_unmarked_board_loses
    losing_bingo_board_clean = <<~BOARD
      22 13 17 11  0
       8  2 23  4 24
      21  9 14 16  7
       6 10  3 18  5
       1 12 20 15 19
    BOARD
    refute BingoBoard.new(losing_bingo_board_clean).winner?
  end

  def test_mark_space_correctly_updates_board
    bingo_board_clean = <<~BOARD
      22 13 17 11  0
       8  2 23  4 24
      21  9 14 16  7
       6 10  3 18  5
       1 12 20 15 19
    BOARD
    bingo_board_marked = <<~BOARD
      22 13 17 11  0
       8  2 23  4 24
      21  9  X 16  7
       6 10  3 18  5
       1 12 20 15 19
    BOARD
    assert bingo_board_marked, BingoBoard.new(bingo_board_clean).mark_space("14")
  end
end

class BingoGame
  attr_accessor :bingo_boards, :draw_order, :last_number_drawn, :winning_board
  attr_reader :board_count, :winning_boards_count

  def initialize(input)
    @input = input.split(/\n\n/)
    @draw_order = @input.shift.split(',')
    @bingo_boards = @input.map { |board| BingoBoard.new(board) }

    @board_count = @bingo_boards.size
    @last_number_drawn = ""
    @winning_board = nil
    @winning_boards_count = 0
  end

  def play
    while !winning_board
      draw_number
      mark_bingo_boards
      check_for_winning_board
    end

    self
  end

  def play_to_lose
    while winning_boards_count < board_count
      draw_number
      mark_bingo_boards
      check_for_winning_board
    end

    self
  end

  def winning_score
    last_number_drawn.to_i * winning_board.collect_unmarked_spaces
  end

  private

  def draw_number
    self.last_number_drawn = draw_order.shift
  end

  def mark_bingo_boards
    bingo_boards.each { |board| board.mark_space(last_number_drawn) }
  end

  def check_for_winning_board
    bingo_boards.each do |board|
      if board.winner?
        self.winning_board = board
        @winning_boards_count += 1
        bingo_boards.delete(board)
      end
    end
  end
end

class BingoBoard
  MARK = "X"

  attr_accessor :bingo_board

  def initialize(board_string)
    @bingo_board = board_string.split("\n").map { |row| row.split(' ')}
  end

  def mark_space(num)
    bingo_board.map! { |row| row.map! { |space| space == num ? MARK : space } }
  end

  def winner?
    winning_column || winning_row
  end

  def collect_unmarked_spaces
    bingo_board.flatten.reject { |n| n == MARK }.map(&:to_i).reduce(&:+)
  end

  def to_s
    <<~FORMATTED_BOARD
      #{bingo_board[0].map { |n| n.rjust(2, ' ') }.join(' ')}
      #{bingo_board[1].map { |n| n.rjust(2, ' ') }.join(' ')}
      #{bingo_board[2].map { |n| n.rjust(2, ' ') }.join(' ')}
      #{bingo_board[3].map { |n| n.rjust(2, ' ') }.join(' ')}
      #{bingo_board[4].map { |n| n.rjust(2, ' ') }.join(' ')}
    FORMATTED_BOARD
  end

  private

  def five_in_a_row(board)
    board.any? { |row| row.eql? Array.new(5, MARK) }
  end

  def winning_row
    five_in_a_row(bingo_board)
  end

  def winning_column
    five_in_a_row(bingo_board.transpose)
  end
end
