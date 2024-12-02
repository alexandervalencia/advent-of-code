require_relative "day_01"

puts "=" * 40
puts "Advent of Code - Day 01"
puts "=" * 40
input = File.read(File.join(__dir__, "input.txt"))
day_01 = Day01.new(input)
puts "Solution: Day One - Part One —— #{day_01.total_distance}"
puts "Solution: Day One - Part Two —— #{day_01.similarity_score}"
