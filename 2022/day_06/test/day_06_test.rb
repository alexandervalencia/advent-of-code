require_relative "../../test_helper"
require_relative "../day_06"

class Day06Test < Minitest::Test
  def examples
    [
      { input: "mjqjpqmgbljsphdztnvjfqwrcgsmlb", marker: 7 },
      { input: "bvwbjplbgvbhsrlpgdmjqwftvncz", marker: 5 },
      { input: "nppdvjthqldpwncqszvftbrmjlhg", marker: 6 },
      { input: "nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg", marker: 10 },
      { input: "zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw", marker: 11 }
    ]
  end

  # The marker is a sequence of four characters with a non-repeating character
  test "it should return the value of characters needed to reach the first marker" do
    examples.each do |e|
      expected = e[:marker]
      assert_equal expected, CommunicationDevice.new(e[:input]).start_of_packet_position
    end
  end
end
