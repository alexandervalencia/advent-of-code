require_relative "day_02"

puts "=" * 40
puts "Advent of Code - Day 02"
puts "=" * 40
input = File.read(File.join(__dir__, "input.txt"))
ids_sum = Day02.new(input).sum_playable_game_ids
sum_of_powers = Day02.new(input).summed_power_of_min_req_cubes
puts "Solution:"
puts "The sum of the IDs of those games is: #{ids_sum}"
puts "The sum of the power of the number of minimum required cubes for all games is: #{sum_of_powers}"
