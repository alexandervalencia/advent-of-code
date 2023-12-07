# GameRecorder
class Day02
  GAME_PIECES = { blue: 14, green: 13, red: 12 }.freeze
  CUBE_COLORS = %w[blue green red]

  def initialize(input)
    @records = parse_input(input)
    @count = 0
  end

  def sum_playable_game_ids
    playable_games =
      @records
        .map { |game| mark_playable_game(game) }
        .filter { |game| game[:playable] }

    playable_games.sum { |g| g[:id] }
  end

  def summed_power_of_min_req_cubes
    @records
      .map { |game| find_min_req_cubes(game) }
      .map { |req| req.reduce(1) { |n, p| n * p } }
      .sum
  end

  def find_min_req_cubes(game)
    blue = game[:sets].max_by { |s| s[:blue] || 0 }[:blue]
    green = game[:sets].max_by { |s| s[:green] || 0 }[:green]
    red = game[:sets].max_by { |s| s[:red] || 0 }[:red]

    [blue, green, red]
  end

  def game_playable?(sets)
    sets.all? do |set|
      set.all? { |color, amount| amount <= GAME_PIECES[color] }
    end
  end

  def mark_playable_game(game)
    game.tap { |g| g[:playable] = game_playable?(g[:sets]) }
  end

  private

  def hasherize_set(set)
    {}.tap do |h|
      CUBE_COLORS.each do |color|
        match = set.scan(/(\d+) #{color}/).flatten

        h[color.to_sym] = match.first.to_i if match.any?
      end
    end
  end

  def parse_input(input)
    parsed =
      input
        .split("\n")
        .map do |line|
          game = line.scan(/Game (\d+): (.*)/).flatten
          { id: game[0].to_i, sets: parse_sets(game[1]), playable: nil }
        end
  end

  def parse_sets(sets)
    sets.split("; ").map { |set| hasherize_set(set) }
  end
end
