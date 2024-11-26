require_relative "day_03"

puts "=" * 40
puts "Advent of Code - Day 03"
puts "=" * 40
input = File.read(File.join(__dir__, "input.txt"))
summed_engine_parts = Day03.new(input).summed_engine_parts
puts "Solution for Part 1 — The sum of all engine parts is: #{summed_engine_parts}"
