require_relative "day_06"

puts "=" * 40
puts "Advent of Code - Day 06"
puts "=" * 40
input = File.read(File.join(__dir__, "input.txt"))
communication_device = CommunicationDevice.new(input)
start_of_packet_position = communication_device.start_of_packet_position
start_of_message_position = communication_device.start_of_message_position
puts "Solution: start-of-packet position begins at #{start_of_packet_position}"
puts "Solution: start-of-message position begins at #{start_of_message_position}"
