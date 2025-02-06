import Foundation

class WeatherViewModel: ObservableObject {
    @Published var dataModel: WeatherDataModel?
    private let weatherRepository: WeatherRepository
    
    init(weatherRepository: WeatherRepository) {
        self.weatherRepository = weatherRepository
        self.fetch()
    }
    
    private func fetch() {
        Task {
            let data = await weatherRepository.fetchWeatherData()
            if let error = data.error {
                dataModel = WeatherDataModel(errorName: error.errorReason,
                                             errorMessage: error.errorMessage)
            } else {
                guard let weather = data.weatherData else { return }
                DispatchQueue.main.async {
                    self.dataModel = WeatherDataModel(location: weather.location ?? "",
                                                      sunriseTime: weather.sunriseTime,
                                                      sunsetTime: weather.sunsetTime,
                                                      weatherCondition: weather.weatherCondition,
                                                      tempC: (weather.tempC ?? "") + "°C",
                                                      feelslikeC: (weather.feelslikeC ?? "") + "°C",
                                                      humidity: (weather.humidity ?? "") + "°C")
                }
            }
        }
    }
}
