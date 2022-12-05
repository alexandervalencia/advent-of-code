require 'pry'

input = File.read("day_05.txt")
example = File.read("day_05_example.txt")

class CrateMover9000
  attr_accessor :crates, :instructions

  def initialize(input)
    @crates, @instructions = input.split("\n\n")
  end

  def top_of_stacks
    move_crates.map(&:first).join
  end

  private

  attr_reader :crates, :instructions

  def move_crates
    crates = read_crates

    read_instructions.each do |line|
      crates_to_move = crates[line[:from] - 1].slice!(0, line[:move])
      target = crates[line[:to] - 1]
      crates_to_move.each { |c| crates[line[:to] - 1].unshift(c) }
    end

    crates
  end

  def read_crates
    lines = @crates.split("\n")
    columns = lines.pop.strip.chars.last.to_i

    crates = lines.map { |line| line.scan(/(\s{3}|\[\w\]\s?)/).flatten }
    arranged = [].tap { |arr| columns.times { arr << [] }}

    crates.each do |column|
      column.each_with_index do |crate, index|
        arranged[index].push(crate) unless crate.nil?
      end
    end

    arranged.map do |col|
      col.reject{ |crate| crate.to_s.strip.empty? }.map { |crate| crate.scan(/[A-Z]/).first }
    end
  end

  def read_instructions
    [].tap do |arr|
      @instructions.split("\n").each do |line|
        move, from, to = line.scan(/\d{1,}/).map(&:to_i)
        arr << { move:, from:, to: }
      end
    end
  end
end

class CrateMover9001 < CrateMover9000
  def move_crates
    crates = read_crates

    read_instructions.each do |line|
      crates_to_move = crates[line[:from] - 1].slice!(0, line[:move])
      crates[line[:to] - 1].unshift(crates_to_move)
      crates[line[:to] - 1].flatten!
    end

    crates
  end
end

p CrateMover9000.new(example).top_of_stacks # => CMZ
p CrateMover9000.new(input).top_of_stacks # => JCMHLVGMG
p CrateMover9001.new(example).top_of_stacks # => MCD
p CrateMover9001.new(input).top_of_stacks # => LVMRWSSPZ
