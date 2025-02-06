import Foundation
import RealmSwift

protocol WeatherDatabase {
    func persistResponse(response: WeatherResponseModel)
    func fetch() -> WeatherDataModel?
}

class RealmWeatherDatabase: WeatherDatabase {
    func persistResponse(response: WeatherResponseModel){
        do {
            let realm = try Realm()
            try realm.write {
                let weatherObject = WeatherPersistedModel(responseModel: response)
                realm.add(weatherObject)
            }
        } catch {
            print("Failed to persist object to realm")
        }
    }
    
    func fetch() -> WeatherDataModel? {
        do {
            let realm = try Realm()
            return realm.objects(WeatherPersistedModel.self)
                .compactMap { self.setupWeatherModel(with: $0) }
                .first
        } catch {
            print("Failed to fetch objects from realm")
            return nil
        }
    }
    
    private func setupWeatherModel(with weather: WeatherPersistedModel) -> WeatherDataModel? {
        return WeatherDataModel(location: "\(String(describing: weather.locationInformation?.area ?? "")), \(String(describing: weather.locationInformation?.country ?? ""))",
                                sunriseTime: weather.forecastInformation?.forecastDay[0].sunriseTime ?? "",
                                sunsetTime:  weather.forecastInformation?.forecastDay[0].sunsetTime ?? "",
                                weatherCondition: WeatherCondition(rawValue: weather.currentWeather?.condition ?? "") ?? .sunny,
                                tempC: String(weather.currentWeather?.tempC ?? 0.0),
                                feelslikeC: String(weather.currentWeather?.feelslikeC ?? 0.0),
                                humidity: String(weather.currentWeather?.humidity ?? 0))
    }
}
