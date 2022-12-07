require_relative "../../test_helper"
require_relative "../day_06"

class Day06Test < Minitest::Test
  def packet_examples
    [
      { input: "mjqjpqmgbljsphdztnvjfqwrcgsmlb", marker: 7 },
      { input: "bvwbjplbgvbhsrlpgdmjqwftvncz", marker: 5 },
      { input: "nppdvjthqldpwncqszvftbrmjlhg", marker: 6 },
      { input: "nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg", marker: 10 },
      { input: "zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw", marker: 11 }
    ]
  end

  def message_examples
    [
      { input: "mjqjpqmgbljsphdztnvjfqwrcgsmlb", marker: 19 },
      { input: "bvwbjplbgvbhsrlpgdmjqwftvncz", marker: 23 },
      { input: "nppdvjthqldpwncqszvftbrmjlhg", marker: 23 },
      { input: "nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg", marker: 29 },
      { input: "zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw", marker: 26 }
    ]
  end

  # The start-of-packet marker is a sequence of four characters with a non-repeating character
  test "it should return the value of characters needed to reach the packet marker" do
    packet_examples.each do |e|
      expected = e[:marker]
      assert_equal expected, CommunicationDevice.new(e[:input]).start_of_packet_position
    end
  end

  # The start-of-message marker is a sequence of four characters with a non-repeating character
  test "it should return the value of characters needed to reach the message marker" do
    message_examples.each do |e|
      expected = e[:marker]
      assert_equal expected, CommunicationDevice.new(e[:input]).start_of_message_position
    end
  end
end
