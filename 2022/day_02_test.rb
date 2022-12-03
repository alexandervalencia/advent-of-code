require_relative "day_02"
require "minitest/autorun"

class Day02Test < Minitest::Test
  def test_play_with_guide
    # A = Rock (1), B = Paper (2), C = Scissors(3)
    # X = Lose (0), Y = Draw  (3), Z = Win     (6)
    assert_equal 3, Game.play_with_guide(["A", "X"]) # (Rock     -> lose -> Scissors)  (0 + 3)
    assert_equal 4, Game.play_with_guide(["A", "Y"]) # (Rock     -> draw -> Rock)      (3 + 1)
    assert_equal 8, Game.play_with_guide(["A", "Z"]) # (Rock     -> win  -> Paper)     (6 + 2)
    assert_equal 1, Game.play_with_guide(["B", "X"]) # (Paper    -> lose -> Rock)      (0 + 1)
    assert_equal 5, Game.play_with_guide(["B", "Y"]) # (Paper    -> draw -> Paper)     (3 + 2)
    assert_equal 9, Game.play_with_guide(["B", "Z"]) # (Paper    -> win  -> Scissors)  (6 + 3)
    assert_equal 2, Game.play_with_guide(["C", "X"]) # (Scissors -> lose -> Paper)     (0 + 2)
    assert_equal 6, Game.play_with_guide(["C", "Y"]) # (Scissors -> draw -> Scissors)  (3 + 3)
    assert_equal 7, Game.play_with_guide(["C", "Z"]) # (Scissors -> win  -> Rock)      (6 + 1)
  end
end
