class Day05
  def initialize(input)
    @input = parse_input(input)
    p @input
  end

  def lowest_location_number
    35
  end

  private

  def parse_input(input)
    seeds,
    seed_to_soil,
    soil_to_fertilizer,
    fertilizer_to_water,
    water_to_light,
    light_to_temperature,
    temperature_to_humidity,
    humidity_to_location =
      input.split("\n\n").map { |l| l.split("\n") }

    {
      seeds:,
      seed_to_soil:,
      soil_to_fertilizer:,
      fertilizer_to_water:,
      water_to_light:,
      light_to_temperature:,
      temperature_to_humidity:,
      humidity_to_location:
    }
  end
end
