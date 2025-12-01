require_relative "day_05"

puts "=" * 40
puts "Advent of Code - Day 05"
puts "=" * 40
input = File.read(File.join(__dir__, "input.txt"))
puts "Solution: Day Five - Part One —— #{Day05.new(input).call}"
puts "Solution: Day Five - Part Two —— #{Day05.new(input, fix_incorrect: true).call}"
