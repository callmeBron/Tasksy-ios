//import RealmSwift
//import Realm
//
//class WeatherPersistedModel: Object, ObjectKeyIdentifiable {
//    @Persisted var currentWeather: CurrentWeatherPersistedModel
//    @Persisted var locationInformation: LocationPersistedModel
//    @Persisted var forecastInformation: ForeCastPersistedModel
//    
//    convenience init(responseModel: WeatherResponseModel) {
//        self.init()
//        self.currentWeather = CurrentWeatherPersistedModel(responseModel: responseModel.current)
//        self.locationInformation = LocationPersistedModel(responseModel: responseModel.location)
//        self.forecastInformation = ForeCastPersistedModel(responseModel: responseModel.forecast)
//    }
//}
//
//class CurrentWeatherPersistedModel: Object, ObjectKeyIdentifiable  {
//    @Persisted var condition: String
//    @Persisted var tempC: Double
//    @Persisted var feelslikeC: Double
//    @Persisted var humidity: Int
//    
//    convenience init(responseModel: CurrentWeatherResponseModel) {
//        self.init()
//        self.condition = responseModel.condition.type
//        self.tempC = responseModel.tempC
//        self.feelslikeC = responseModel.feelslikeC
//        self.humidity = responseModel.humidity
//    }
//}
//
//class LocationPersistedModel: Object, ObjectKeyIdentifiable  {
//    @Persisted var area: String
//    @Persisted var country: String
//    
//    convenience init(responseModel: LocationResponseModel) {
//        self.init()
//        self.area = responseModel.name
//        self.country = responseModel.country
//    }
//}
//
//class ForeCastPersistedModel: Object, ObjectKeyIdentifiable  {
//    @Persisted var forecastDay = List<ForeCastDayPersistedModel>()
//    
//    convenience init(responseModel: ForecastResponseModel) {
//        self.init()
//        self.forecastDay.append(ForeCastDayPersistedModel(responseModel: responseModel.forecastday))
//    }
//}
//
//class ForeCastDayPersistedModel: Object, ObjectKeyIdentifiable {
//    @Persisted var sunriseTime: String
//    @Persisted var sunsetTime: String
//    
//    convenience init(responseModel: [ForecastDayResponseModel]) {
//        self.init()
//        self.sunriseTime = responseModel[0].astro.sunrise
//        self.sunsetTime = responseModel[0].astro.sunset
//    }
//}
