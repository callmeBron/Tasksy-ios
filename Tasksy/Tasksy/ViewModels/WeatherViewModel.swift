import Foundation

class WeatherViewModel: ObservableObject {
    @Published var dataModel: WeatherViewDataModel?
    var shouldShowEmptyMessage: Bool = false
    private let weatherRepository: WeatherRepository
    
    init(weatherRepository: WeatherRepository) {
        self.weatherRepository = weatherRepository
        self.fetch()
    }
    
    private func fetch() {
        Task {
            let data = await weatherRepository.fetchWeatherData()
            if let error = data.error {
                dataModel = WeatherViewDataModel(errorData: ErrorResponse(errorReason: error.errorReason,
                                                                          errorMessage: error.errorMessage))
            } else {
                guard let weather = data.weatherData else { shouldShowEmptyMessage = true ; return }
                DispatchQueue.main.async {
                    let model = WeatherDataModel(location: weather.location ?? "",
                                                 sunriseTime: weather.sunriseTime,
                                                 sunsetTime: weather.sunsetTime,
                                                 weatherCondition: weather.weatherCondition,
                                                 tempC: (weather.tempC ?? "") + "°C",
                                                 feelslikeC: (weather.feelslikeC ?? "") + "°C",
                                                 humidity: (weather.humidity ?? "") + "°C")
                    self.dataModel = WeatherViewDataModel(weatherData: model)
                }
            }
        }
    }
}
