#require "ostruct"
require "dry-types"
require "dry-struct"
require "representable"

module Types
  include Dry.Types()
end

class WeatherConditions < Dry::Struct
  attribute :feelsLikeC, Types::Coercible::Integer.default(20)
  attribute :precipMM, Types::Coercible::Float.default(0)
  attribute :windspeedKmph, Types::Coercible::Integer.default(0)

  def personalised_forecast
    conditions = []

    if stay_home?
      conditions << "it's windy" if strong_wind?
      conditions << "it's raining" if raining?
      conditions << "it's cold" if colder_than_12C?
      "Stay home (#{conditions.join(', ')})"
    end
  end

  def stay_home?
    raining? || strong_wind? || colder_than_12C?
  end

  def raining?
    precipMM > 0
  end

  def strong_wind?
    windspeedKmph > 9
  end

  def colder_than_12C?
    feelsLikeC < 12
  end
end

class WeatherConditionsRepresenter < Representable::Decorator
  include Representable::JSON

  property :feelsLikeC
  property :precipMM
  property :windspeedKmph
end

conditions_json = <<-JSON
        {
            "FeelsLikeC": "13",
            "FeelsLikeF": "55",
            "cloudcover": "0",
            "humidity": "88",
            "localObsDateTime": "2020-10-03 09:28 PM",
            "observation_time": "08:28 AM",
            "precipMM": "0.0",
            "pressure": "1032",
            "temp_C": "13",
            "temp_F": "55",
            "uvIndex": "4",
            "visibility": "10",
            "weatherCode": "113",
            "weatherDesc": [
                {
                    "value": "Sunny"
                }
            ],
            "weatherIconUrl": [
                {
                    "value": ""
                }
            ],
            "winddir16Point": "WSW",
            "winddirDegree": "250",
            "windspeedKmph": "9",
            "windspeedMiles": "6"
        }
JSON

conditions = WeatherConditions.new
p conditions
#weather_conditions = WeatherConditionsRepresenter.new(conditions).from_json conditions_json
#p weather_conditions.FeelsLikeC, weather_conditions.precipMM
