require_relative "day_01"

puts "=" * 40
puts "Advent of Code - Day 01"
puts "=" * 40
input = File.read(File.join(__dir__, "input.txt"))
calibration_number = CalibrationMachine.new(input).run
real_calibration_number = CalibrationMachine.new(input, true).run
puts "Solution: the calibration number is #{calibration_number}"
puts "Solution: the _REAL_ calibration number is #{real_calibration_number}"
