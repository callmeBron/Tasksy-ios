import Foundation
/// responsible to fetch from either the data base(realm) or make the service call again, will communicate with the viewModel
protocol WeatherRepository {
    func fetchWeatherData() async -> (weatherData: WeatherDataModel?,error: ErrorResponse?)
}

class ConcreteWeatherRepository: WeatherRepository {
    private let dataBase: WeatherDatabase
    private let webService: WeatherServiceAPI
    
    init(dataBase: WeatherDatabase, webService: WeatherServiceAPI) {
        self.dataBase = dataBase
        self.webService = webService
    }
    
    func fetchWeatherData() async -> (weatherData: WeatherDataModel?, error: ErrorResponse?) {
        guard let storedDate = UserDefaults.standard.object(forKey: "lastUpdateTime") as? Date else {
            return await fetchWeatherServiceData()
        }
        
        let calendar = Calendar.current
        
        if let thirtyMinutesAgo = calendar.date(byAdding: .minute, value: -30, to: Date()),
           storedDate >= thirtyMinutesAgo {
            return (fetchWeatherFromDatabase(), nil)
        } else {
            return await fetchWeatherServiceData()
        }
    }
    
    private func fetchWeatherServiceData() async -> (WeatherDataModel?, ErrorResponse?) {
        UserDefaults.standard.set(Date(), forKey: "lastUpdateTime")
        let response = await webService.fetchWeatherInformation()
        switch response {
        case .success(let weatherData):
            dataBase.persistResponse(response: weatherData)
            let weatherModel = dataBase.fetch()
            return (weatherModel, nil)
        case .failure(let error):
            return (nil, error)
        }
    }
    
    private func fetchWeatherFromDatabase() -> WeatherDataModel? {
        return dataBase.fetch()
    }
}
