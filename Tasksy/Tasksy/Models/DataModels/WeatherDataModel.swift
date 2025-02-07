import Foundation
import SwiftUI

struct WeatherViewDataModel {
    let weatherData: WeatherDataModel?
    let errorData: ErrorResponse?
    
    init(weatherData: WeatherDataModel? = nil, errorData: ErrorResponse? = nil) {
        self.weatherData = weatherData
        self.errorData = errorData
    }
}

struct WeatherDataModel {
    let errorName: String?
    let errorMessage: String?
    let location: String?
    let sunriseTime: String?
    let sunsetTime: String?
    let weatherCondition: WeatherCondition?
    let tempC: String?
    let feelslikeC: String?
    let humidity: String?
    
    init(errorName: String? = nil,
         errorMessage: String? = nil,
         location: String? = nil,
         sunriseTime: String? = nil,
         sunsetTime: String? = nil,
         weatherCondition: WeatherCondition? = nil,
         tempC: String? = nil,
         feelslikeC: String? = nil,
         humidity: String? = nil) {
        self.errorName = errorName
        self.errorMessage = errorMessage
        self.location = location
        self.sunriseTime = sunriseTime
        self.sunsetTime = sunsetTime
        self.weatherCondition = weatherCondition
        self.tempC = tempC
        self.feelslikeC = feelslikeC
        self.humidity = humidity
    }
}
