require_relative "../../test_helper"
require_relative "../day_08"

class Day08Test < Minitest::Test
  test "wat it do" do
    input = <<~INPUT
RL

AAA = (BBB, CCC)
BBB = (DDD, EEE)
CCC = (ZZZ, GGG)
DDD = (DDD, DDD)
EEE = (EEE, EEE)
GGG = (GGG, GGG)
ZZZ = (ZZZ, ZZZ)
  INPUT
    assert_equal 2, Day08.new(input).steps_to_zzz
  end

  test "wat it do 2" do
    input = <<~INPUT
LLR

AAA = (BBB, BBB)
BBB = (AAA, ZZZ)
ZZZ = (ZZZ, ZZZ)
  INPUT

    assert_equal 6, Day08.new(input).steps_to_zzz
  end

  test "ghost map" do
    input = <<~INPUT
LR

11A = (11B, XXX)
11B = (XXX, 11Z)
11Z = (11B, XXX)
22A = (22B, XXX)
22B = (22C, 22C)
22C = (22Z, 22Z)
22Z = (22B, 22B)
XXX = (XXX, XXX)
    INPUT

    assert_equal 6, Day08.new(input).ghostly_steps_to_all_zs
  end
end
