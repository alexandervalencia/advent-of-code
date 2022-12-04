input = File.read("day_04.txt").split("\n").map { |pair| pair.split(",") }
example = File.read("day_04_example.txt").split("\n").map { |pair| pair.split(",") }
# example => [["2-4", "6-8"], ["2-3", "4-5"], ["5-7", "7-9"], ["2-8", "3-7"], ["6-6", "4-6"], ["2-6", "4-8"]]

class SectionAssignment
  attr_reader :first_lower, :first_upper :second_lower, :second_upper
  def initialize(assignees)
    first, second = assignees
    @first_lower, @first_upper = first.split("-").map(&:to_i)
    @second_lower, @second_upper = second.split("-").map(&:to_i)
  end

  def complete_section_overlap?
    case true
    when first_lower.between?(second_lower, second_upper) &&
           first_upper.between?(second_lower, second_upper)
      true
    when second_lower.between?(first_lower, first_upper) &&
           second_upper.between?(first_lower, first_upper)
      true
    else
      false
    end
  end

  def partial_section_overlap?
    case true
    when first_lower.between?(second_lower, second_upper) ||
           first_upper.between?(second_lower, second_upper)
      true
    when second_lower.between?(first_lower, first_upper) ||
           second_upper.between?(first_lower, first_upper)
      true
    else
      false
    end
  end
end

p example.map { |section| SectionAssignment.new(section).complete_section_overlap? }.count(true) # 2
p input.map { |section| SectionAssignment.new(section).complete_section_overlap? }.count(true) # 595

p example.map { |section| SectionAssignment.new(section).section_overlap? }.count(true) # 4
p input.map { |section| SectionAssignment.new(section).section_overlap? }.count(true) # 952
