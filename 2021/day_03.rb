require "minitest/autorun"

class TheTest < Minitest::Test
  def example_input
    <<~EXAMPLE_INPUT
      00100
      11110
      10110
      10111
      10101
      01111
      00111
      11100
      10000
      11001
      00010
      01010
    EXAMPLE_INPUT
  end

  def real_input
    File.read("./day_03.txt")
  end

  def test_part_one_example
    subject = SubmarineDiagnostic.new(example_input)
    assert_equal 198, subject.power_consumption
  end

  def test_part_one_solution
    subject = SubmarineDiagnostic.new(real_input)
    assert_equal 1131506, subject.power_consumption
  end

  def test_part_two_example
    subject = SubmarineDiagnostic.new(example_input)
    assert_equal 230, subject.find_life_support_rating
  end

  def test_part_two_solution
    subject = SubmarineDiagnostic.new(real_input)
    assert_equal 7863147, subject.find_life_support_rating
  end
end

class SubmarineDiagnostic
  attr_accessor :binary_list_columns
  attr_reader :binary_list, :columns_count

  def initialize(input)
    @binary_list = input.split("\n")
    @binary_list_columns = @binary_list.map(&:chars).transpose.map(&:join)
    @columns_count = @binary_list_columns.size.freeze
  end

  def get_gamma_and_epsilon_bits(lists)
    lists.reduce(['', '']) do |memo, column|
      common_bits_hash = get_most_and_least_common_bits_from_column(column)

      memo.tap do |m|
        m[0] += common_bits_hash[:most]
        m[1] += common_bits_hash[:least]
      end
    end
  end

  def get_most_and_least_common_bits_from_column(column)
    zeros = column.count('0')
    ones = column.length - zeros

    {}.tap do |hash|
      if zeros > ones
        hash[:least] = '1'
        hash[:most] = '0'
      elsif ones > zeros
        hash[:least] = '0'
        hash[:most] = '1'
      end
    end
  end

  def get_least_common_bits_from_column(column)
    zeros = column.count('0')
    ones = column.length - zeros

    zeros > ones ? '1' : '0'
  end

  def get_most_common_bits_from_column(column)
    zeros = column.count('0')
    ones = column.length - zeros

    zeros > ones ? '0' : '1'
  end

  def power_consumption
    gamma_rate_bits, epsilon_rate_bits = get_gamma_and_epsilon_bits(binary_list_columns)

    gamma_rate_bits.to_i(2) * epsilon_rate_bits.to_i(2)
  end

  def find_life_support_rating
    oxygen_binary_list = Array.new(binary_list)
    c02_binary_list = Array.new(binary_list)

    columns_count.times do |i|
      oxygen_columns = oxygen_binary_list.map(&:chars).transpose.map(&:join)
      c02_columns = c02_binary_list.map(&:chars).transpose.map(&:join)

      oxygen_bit = get_most_common_bits_from_column(oxygen_columns[i])
      c02_bit = get_least_common_bits_from_column(c02_columns[i])

      oxygen_binary_list.delete_if { |rating| rating[i] != oxygen_bit } unless oxygen_binary_list.size == 1
      c02_binary_list.delete_if { |rating| rating[i] != c02_bit } unless c02_binary_list.size == 1
    end
    oxygen_rating = oxygen_binary_list[0].to_i(2)
    c02_rating = c02_binary_list[0].to_i(2)

    oxygen_rating * c02_rating
  end
end
