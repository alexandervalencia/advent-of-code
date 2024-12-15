require_relative "day_04"

puts "=" * 40
puts "Advent of Code - Day 04"
puts "=" * 40
input = File.read(File.join(__dir__, "input.txt"))
puts "Solution: Day Four - Part One —— #{Day04.new(input).call}"
# puts "Solution: Day Four - Part Two —— #{Day04.new(input).call}"
