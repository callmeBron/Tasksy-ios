import Foundation
import SwiftUI

struct WeatherDataModel {
    let locationArea: String
    let locationCountry: String
    let sunriseTime: String
    let sunsetTime: String
    let weatherCondition: WeatherCondition
    let tempC: Double
    let feelslikeC: Double
    let humidity: Int
}
