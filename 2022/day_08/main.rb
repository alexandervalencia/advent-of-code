require_relative "day_08"

puts "=" * 40
puts "Advent of Code - Day 08"
puts "=" * 40
input = File.read(File.join(__dir__, "input.txt"))
tree_house = TreeHouse.new(input)
visible_trees = tree_house.visible_trees
highest_scenic_score = tree_house.highest_scenic_score
puts "Solution: the total number of visible trees is #{visible_trees}"
puts "Solution: highest possbile scenic score is #{highest_scenic_score}"
