#!/usr/bin/env ruby

require "colorize"
require "fileutils"
require "optparse"
require_relative "aoc_api"

options = {}
OptionParser
  .new do |opts|
    opts.banner = "Usage: setup_day.rb [options]"

    opts.on("-d", "--debug", "Debug input and setup") do |d|
      options[:debug] = d
    end
  end
  .parse!

day = ARGV[0].to_s.rjust(2, "0")
path =
  File.join(ENV.fetch("HOME"), "src", "advent_of_code", "2022", "day_#{day}")
instructions_file = File.join(path, "instructions.md")
input_file = File.join(path, "input.txt")
main_file = File.join(path, "main.rb")
day_file_name = "day_#{day}"
day_file = File.join(path, "#{day_file_name}.rb")
test_file = File.join(path, "test", "day_#{day}_test.rb")
test_name = "Day#{day}Test"

puts "⚙️  Setting up day: #{day}".light_blue

if options[:debug]
  puts "=" * 80
  puts "DEBUG:"
  puts "options #{options}"
  puts "ARGV #{ARGV}"
  puts "day #{day}"
  puts "instructions_file #{instructions_file}"
  puts "input_file #{input_file}"
  puts "main_file #{main_file}"
  puts "day_file_name #{day_file_name}"
  puts "day_file #{day_file}"
  puts "test_file #{test_file}"
  puts "test_name #{test_name}"
  puts "=" * 80
end

FileUtils.mkdir_p "#{path}/test"
FileUtils.touch day_file
FileUtils.touch main_file
FileUtils.touch test_file

aoc_api = AocApi.new(day)
File.write(instructions_file, aoc_api.download_instructions)
File.write(input_file, aoc_api.download_input)

if File.zero?(test_file)
  test_content = <<~TEST_CONTENT
require_relative "../../test_helper"
require_relative "../#{day_file_name}"

class #{test_name} < Minitest::Test
  test "wat it do" do
    skip
  end
end
TEST_CONTENT
  File.write(test_file, test_content)
end

if File.zero?(main_file)
  main_content = <<~MAIN_CONTENT
require_relative "#{day_file_name}"

puts "=" * 40
puts "Advent of Code - Day #{day}"
puts "=" * 40
input = File.read(File.join(__dir__, "input.txt"))
puts "Solution: TODO"
MAIN_CONTENT
  File.write(main_file, main_content)
end

puts "✅ Done".light_blue
