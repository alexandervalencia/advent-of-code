require_relative "../../test_helper"
require_relative "../day_02"

class Day02Test < Minitest::Test
  INPUT = <<~TXT
Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green
Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue
Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red
Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red
Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green
  TXT

  describe "Day02" do
    test "#sum_playable_game_ids" do
      skip
      subject = described_class.new(INPUT)

      assert_equal 8, subject.sum_playable_game_ids
    end

    test "#game_playable?" do
      skip
      subject = described_class.new(INPUT)

      assert subject.game_playable?([{ blue: 1, red: 1, green: 1 }])
      refute subject.game_playable?([{ blue: 100, red: 100, green: 100 }])
    end

    test "#summed_power_of_min_req_cubes" do
      subject = described_class.new(INPUT)

      assert_equal 2286, subject.summed_power_of_min_req_cubes
    end

    test "#find_min_req_cubes" do
      skip
      subject = described_class.new(INPUT)
      game = {
        id: 1,
        sets: [
          { blue: 3, red: 4 },
          { blue: 6, green: 2, red: 1 },
          { green: 2 }
        ],
        playable: nil
      }

      assert_equal [6, 2, 4], subject.find_min_req_cubes(game)
    end
  end
end
