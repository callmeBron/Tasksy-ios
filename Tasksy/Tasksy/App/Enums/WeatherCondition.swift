import SwiftUICore

enum WeatherCondition: String {
    case cloudy = "a"
    case sunny = "c"
    case partlyCloudy = "d"
    case rainy = "e"
    
    var weatherConditionIcon: Image {
        switch self {
        case .cloudy:
            Image(systemName: "")
        case .sunny:
            Image(systemName: "")
        case .partlyCloudy:
            Image(systemName: "")
        case .rainy:
            Image(systemName: "")
        }
    }
}
