require_relative "../../test_helper"
require_relative "../day_12"

class Day12Test < Minitest::Test
  INPUT = <<~INPUT
???.### 1,1,3
.??..??...?##. 1,1,3
?#?#?#?#?#?#?#? 1,3,1,6
????.#...#... 4,1,1
????.######..#####. 1,6,5
?###???????? 3,2,1
  INPUT

  test "wat it do" do
    assert_equal 21, Day12.new(INPUT).spring_count
  end
end
