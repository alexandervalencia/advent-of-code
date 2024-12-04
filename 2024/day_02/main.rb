require_relative "day_02"

puts "=" * 40
puts "Advent of Code - Day 02"
puts "=" * 40
input = File.read(File.join(__dir__, "input.txt"))
puts "Solution: Day Two - Part One —— #{Day02.new(input).safe_reports}"
puts "Solution: Day Two - Part Two —— #{Day02.new(input, problem_dampener: true).safe_reports}"
