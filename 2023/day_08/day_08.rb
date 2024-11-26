class Day08
  def initialize(input)
    @dir, @steps = parse_input(input)
  end

  def steps_to_zzz
    walk_the_steps { |pointer| pointer === "ZZZ" }
  end

  def walk_the_steps(&block)
    found = false
    count = 0
    pointer = "AAA"
    dir = @dir.map(&:clone)
    while found == false
      cur_dir = dir.shift.to_sym
      dir = @dir.map(&:clone) if dir.empty?
      pointer = @steps[pointer][cur_dir]
      found = yield pointer

      count += 1
    end

    count
  end

  def ghostly_steps_to_all_zs
    pointers = @steps.keys.select { |k| /A$/.match?(k) }
    ends = @steps.keys.select { |k| /Z$/.match?(k) }

    indices = (0..pointers.count - 1).to_a

    6
  end

  private

  def parse_input(input)
    dir, steps = input.split("\n\n")
    steps_hash =
      {}.tap do |h|
        steps
          .split("\n")
          .each do |step|
            id, l, r = step.scan(/\w+/)
            h[id] = { l:, r: }
          end
      end

    [dir.chars.map(&:downcase), steps_hash]
  end
end
