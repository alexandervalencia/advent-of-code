input = File.read("day_02.txt").split("\n").map { |pair| pair.split(" ") }
example = File.read("day_02_example.txt").split("\n").map { |pair| pair.split(" ") } # [["A", "Y"], ["B", "X"], ["C", "Z"]]

class Game
  SHAPE_VALUE = { "RockShape": 1, "PaperShape": 2, "ScissorsShape": 3 }

  def self.play(pair)
    first, second = pair.map { |ltr| get_shape(ltr) }

    match_result(first, second) + SHAPE_VALUE[second.class.name.to_sym]
  end

  def self.play_with_guide(pair)
    first = get_shape(pair.first)
    encoded_outcome = pair.last
    second = first.get_opponent_by_outcome(encoded_outcome)

    match_result(first, second) + SHAPE_VALUE[second.class.name.to_sym]
  end

  def self.get_shape(encoded_shape)
    case encoded_shape
      when "A", "X"
        RockShape.new
      when "B", "Y"
        PaperShape.new
      when "C", "Z"
        ScissorsShape.new
    end
  end

  def self.match_result(first, second)
    second.result(first)
  end
end

class RockShape
  def get_opponent_by_outcome(outcome_for_opponent)
    case outcome_for_opponent
    when "Y" # draw
      RockShape.new
    when "X" # lose
      ScissorsShape.new
    when "Z" # win
      PaperShape.new
    end
  end

  def result(opponent)
    case opponent
      when RockShape
        3
      when PaperShape
        0
      when ScissorsShape
        6
    end
  end
end

class PaperShape
  def get_opponent_by_outcome(outcome_for_opponent)
    case outcome_for_opponent
    when "Y" # draw
      PaperShape.new
    when "X" # lose
      RockShape.new
    when "Z" # win
      ScissorsShape.new
    end
  end

  def result(opponent)
    case opponent
    when RockShape
      6
    when PaperShape
      3
    when ScissorsShape
      0
    end
  end
end

class ScissorsShape
  def get_opponent_by_outcome(outcome_for_opponent)
    case outcome_for_opponent
    when "Y" # draw
      ScissorsShape.new
    when "X" # lose
      PaperShape.new
    when "Z" # win
      RockShape.new
    end
  end

  def result(opponent)
    case opponent
    when RockShape
      0
    when PaperShape
      6
    when ScissorsShape
      3
    end
  end
end

class GameRunner
  def self.run(pairs_list)
    pairs_list.map { |pair| Game.play(pair) }.sum
  end

  def self.guided_run(pairs_list)
    pairs_list.map { |pair| Game.play_with_guide(pair) }.sum
  end
end

p GameRunner.run(example) # 15

p GameRunner.run(input) # 13052

p GameRunner.guided_run(example) # 12

p GameRunner.guided_run(input) #
