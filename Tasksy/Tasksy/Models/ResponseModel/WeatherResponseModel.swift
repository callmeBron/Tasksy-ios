import Foundation

struct WeatherResponseModel: Decodable {
    let currentWeatherResponse: currentWeatherResponseModel
}

struct currentWeatherResponseModel: Decodable {
    let condition: Condition
    let tempC: Double
    let feelslikeC: Double
    let humidity: Int
    let isDay: Int

    enum CodingKeys: String, CodingKey {
        case tempC = "temp_c"
        case feelslikeC = "feelslike_c"
        case humidity
        case isDay = "is_day"
        case condition
    }
}

struct Condition: Decodable {
    let text: String
}
