input = File.read('day_02.txt').split("\n")
example = [
  'forward 5',
  'down 5',
  'forward 8',
  'up 3',
  'down 8',
  'forward 2'
]

class Submarine
  DIRECTIONS = {
    'forward' => [1, 0],
    'down' => [0, 1],
    'up' => [0, -1]
  }
  attr_accessor :aim, :directions, :position

  def initialize(directions)
    @aim = 0
    @directions = directions
    @position = [0, 0]
  end

  def travel
    directions.each do |d|
      direction, amount = d.split(' ')

      amount.to_i.times do
        position[0] += DIRECTIONS[direction][0]
        position[1] += DIRECTIONS[direction][1]
      end
    end

    self
  end

  def multiply_position
    position.first * position.last
  end
end

puts Submarine.new(example).travel.multiply_position

puts Submarine.new(input).travel.multiply_position

class MoreComplicatedSubmarine < Submarine
  attr_accessor :aim, :directions, :position

  def initialize(directions)
    @aim = 0
    @directions = directions
    @position = [0, 0]
  end

  def travel
    directions.each do |d|
      direction, amount = d.split(' ')

      send(direction.to_sym, amount.to_i)
    end

    self
  end

  def multiply_position
    position.first * position.last
  end

  private

  def forward(units)
    position[0] += units
    position[1] += (aim * units)
  end

  def down(units)
    @aim += units
  end

  def up(units)
    @aim -= units
  end
end

puts MoreComplicatedSubmarine.new(example).travel.multiply_position

puts MoreComplicatedSubmarine.new(input).travel.multiply_position
