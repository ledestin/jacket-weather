require "../jacket-weather"

describe "Jacket Weather" do
  context "tells me whether I want to be outside" do
    let(:windy_weather) do
      WeatherConditions.new windspeedKmph: 15
    end
    let(:rainy_weather) do
      WeatherConditions.new precipMM: 5.1
    end
    let(:cold_weather) do
      WeatherConditions.new feelsLikeC: 10
    end
    let(:worst_weather) do
      WeatherConditions.new windspeedKmph: 30, precipMM: 10, feelsLikeC: 5
    end

    it "tells me I don't want to be outside if it's windy" do
      expect(windy_weather.personalised_forecast).to eq "Stay home (it's windy)"
    end

    it "tells me I don't want to be outside if it's raining" do
      expect(rainy_weather.personalised_forecast).to eq "Stay home (it's raining)"
    end

    it "tells me I don't want to be outside if it's cold" do
      expect(cold_weather.personalised_forecast).to eq "Stay home (it's cold)"
    end

    it "tells me I don't want to be outside if it's windy, raining, cold" do
      expect(worst_weather.personalised_forecast).to eq \
        "Stay home (it's windy, it's raining, it's cold)"
    end
  end
end
