require_relative "day_08"

puts "=" * 40
puts "Advent of Code - Day 08"
puts "=" * 40
input = File.read(File.join(__dir__, "input.txt"))
steps_to_zzz = Day08.new(input).steps_to_zzz
puts "Solution: day 1 - number of steps: #{steps_to_zzz}"
