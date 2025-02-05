import Foundation

struct WeatherResponseModel: Codable {
    let location: LocationResponseModel
    let current: CurrentWeatherResponseModel
    let forecast: ForecastResponseModel
}

// MARK: - Location Response
struct LocationResponseModel: Codable {
    let name: String
    let country: String
}

// MARK: - Current Weather Response
struct CurrentWeatherResponseModel: Codable {
    let condition: WeatherConditionResponseModel
    let tempC: Double
    let feelslikeC: Double
    let humidity: Int

    enum CodingKeys: String, CodingKey {
        case tempC = "temp_c"
        case feelslikeC = "feelslike_c"
        case humidity
        case condition
    }
}

struct WeatherConditionResponseModel: Codable {
    let type: String
    enum CodingKeys: String, CodingKey {
        case type = "text"
    }
}

// MARK: - Forecast Response
struct ForecastResponseModel: Codable {
    let forecastday: [ForecastDayResponseModel]
}

// MARK: - Forecastday Response
struct ForecastDayResponseModel: Codable {
    let astro: AstroResponseModel
}

// MARK: - Astro Response
struct AstroResponseModel: Codable {
    let sunrise: String
    let sunset: String
    enum CodingKeys: String, CodingKey {
        case sunrise
        case sunset
    }
}
