require_relative "day_07"

puts "=" * 40
puts "Advent of Code - Day 07"
puts "=" * 40
input = File.read(File.join(__dir__, "input.txt"))
total_winnings = Day07.new(input).total_winnings
total_winnings_with_jokers = Day07.new(input, true).total_winnings
puts "Solution for Part 1 — Total Winnings: #{total_winnings}"
puts "Solution for Part 1 — Total Winnings with Jokers: #{total_winnings_with_jokers}"
