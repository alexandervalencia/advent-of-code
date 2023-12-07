class Day06
  STARTING_SPEED = 0

  def initialize(input, trim: false)
    @input = parse_input(input, trim)
  end

  def multipled_ways_to_win
    normalized_race_info.map { |race| ways_to_win(**race) }.reduce(&:*)
  end

  def ways_to_win(**race)
    devise_winning_range(**race).count
  end

  def find_first_winning_strategy(
    hold_time = 0,
    op = :+,
    distance_to_beat:,
    race_time:
  )
    while true
      if (winning_strategy?(distance_to_beat:, hold_time:, race_time:))
        break
      else
        hold_time = hold_time.public_send(op, 1)
      end
    end

    hold_time
  end

  def devise_winning_range(distance_to_beat:, race_time:)
    lower = find_first_winning_strategy(distance_to_beat:, race_time:)
    upper =
      find_first_winning_strategy(race_time, :-, distance_to_beat:, race_time:)

    (lower..upper).to_a
  end

  def winning_strategy?(distance_to_beat:, hold_time:, race_time:)
    ticks = race_time - hold_time
    distance_traveled = ticks * hold_time

    distance_traveled > distance_to_beat
  end

  private

  def parse_input(input, trim = false)
    parsed = input.split("\n")
    parsed = parsed.map { |l| l.gsub(/\s+/, "") } if trim

    parsed.map { |l| l.scan(/(\d+)/).flatten }
  end

  def normalized_race_info
    time, distance = @input.map { |l| l.map(&:to_i) }

    time.map.with_index do |race_time, i|
      { race_time: race_time, distance_to_beat: distance[i] }
    end
  end
end
