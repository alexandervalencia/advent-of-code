input = File.read("day_03.txt").split("\n")
example = File.read("day_03_example.txt").split("\n")

class RucksackPrioritizer
  attr_reader :rucksacks
  attr_reader :priority_dict

  def initialize(rucksacks)
    @rucksacks = rucksacks
    @priority_dict = build_priority_dict
  end

  def get_priority_sum
    rucksacks.map do |sack|
      compartment_one, compartment_two = halve_string(sack)
      common_char = find_common_char(compartment_one, compartment_two)
      priority_dict[common_char]
    end.sum
  end

  def find_group_badge
    rucksacks.each_slice(3).map do |container|
      i1, i2, i3 = container
      common_char = find_common_char(i1, i2, i3)
      priority_dict[common_char]
    end.sum
  end

  private

  def build_priority_dict
    dict = {}.tap do |d|
      [*"a".."z", *"A".."Z"].each_with_index { |l,i| d[l] = i + 1 }
    end
  end

  def find_common_char(str1, str2, str3 = "")
    return (str1.chars & str2.chars & str3.chars).join unless str3.empty?

    (str1.chars & str2.chars).join
  end

  def halve_string(str)
    str.chars.each_slice(str.length / 2).map(&:join)
  end
end

# p RucksackPrioritizer.new(example).get_priority_sum # 157

# p RucksackPrioritizer.new(input).get_priority_sum # 7701

p RucksackPrioritizer.new(example).find_group_badge #70

p RucksackPrioritizer.new(input).find_group_badge # 2644
