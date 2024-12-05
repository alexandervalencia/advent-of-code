require_relative "day_03"

puts "=" * 40
puts "Advent of Code - Day 03"
puts "=" * 40
input = File.read(File.join(__dir__, "input.txt"))
puts "Solution: Day Three - Part One —— #{Day03.new(input).call}"
puts "Solution: Day Three - Part Two —— #{Day03.new(input, handle_instructions: true).call}"
