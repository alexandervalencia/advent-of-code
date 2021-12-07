input = File.read('day_01.txt').split.map(&:to_i)
example = [199, 200, 208, 210, 200, 207, 240, 269,
           260, 263]

class SonarSweep
  attr_accessor :measurements

  def initialize(measurements)
    @measurements = measurements
  end

  def depth_increases(depths = measurements)
    increases = 0
    depths.each_cons(2) do |m|
      prev, curr = m
      increases += 1 if curr > prev
    end
    increases
  end

  def three_depth_increases
    three_depth_measurements = [].tap do |arr|
      measurements.each_cons(3) { |m| arr.push(m.sum) }
    end

    depth_increases(three_depth_measurements)
  end
end

puts SonarSweep.new(example).depth_increases # 7

puts SonarSweep.new(input).depth_increases # 1154

puts SonarSweep.new(example).three_depth_increases # 5

puts SonarSweep.new(input).three_depth_increases # 1127
