class Day02
  def initialize(input, problem_dampener: false)
    @input = parse_input(input)
    @problem_dampener = problem_dampener
  end

  def safe_reports
    @input
      .map do |report|
        report = remove_one_unsafe_distance(report) if (@problem_dampener)
        safe_report?(report)
      end
      .count(true)
  end

  def safe_report?(report)
    one_direction?(report) && safe_distance?(report)
  end

  # private

  def ascending?(arr)
    arr.each_cons(2).all? { |left, right| left < right }
  end

  def descending?(arr)
    arr.each_cons(2).all? { |left, right| left > right }
  end

  def diff(a, b)
    (a - b).abs
  end

  def one_direction?(arr)
    (ascending?(arr) && !descending?(arr)) ||
      (!ascending?(arr) && descending?(arr))
  end

  def safe_distance?(arr)
    arr
      .each_cons(2)
      .all? { |left, right| 1 <= diff(left, right) && diff(left, right) <= 3 }
  end

  def remove_one_unsafe_distance(arr)
    safe = false

    arr.each_with_index do |_, i|
      break if (safe)
      potentially_safe_arr = arr.dup
      potentially_safe_arr.delete_at(i)
      safe = true if safe_report?(potentially_safe_arr)
      arr = potentially_safe_arr if safe
    end

    arr
  end

  def parse_input(input)
    input.split("\n").map { |line| line.split(" ").map(&:to_i) }
  end
end
