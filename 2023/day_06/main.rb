require_relative "day_06"

puts "=" * 40
puts "Advent of Code - Day 06"
puts "=" * 40
input = File.read(File.join(__dir__, "input.txt"))
multipled_ways_to_win = Day06.new(input).multipled_ways_to_win
multipled_ways_to_win_big_race =
  Day06.new(input, trim: true).multipled_ways_to_win
puts "Solution — Part 1: #{multipled_ways_to_win}"
puts "Solution — Part 2: #{multipled_ways_to_win_big_race}"
