import SwiftUICore

enum WeatherCondition: String {
    case cloudy = "Cloudy"
    case sunny = "Sunny"
    case partlyCloudy = "Partly cloudy"
    case rainy = "Heavy rain"
    
    var weatherConditionIcon: Image {
        switch self {
        case .cloudy:
            return Image(systemName: "cloud.fill")
        case .sunny:
            return Image(systemName: "sun.max.fill")
        case .partlyCloudy:
            return Image(systemName: "cloud.sun.fill")
        case .rainy:
            return Image(systemName: "cloud.rain.fill")
        }
    }
    
    var temperatureColor: Color {
        switch self {
        case .cloudy:
            return Color.gray
        case .sunny:
            return Color.yellow
        case .partlyCloudy:
            return Color.gray
        case .rainy:
            return Color.pastelBlue
        }
    }
}
