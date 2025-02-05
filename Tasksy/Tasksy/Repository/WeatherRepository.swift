//import Foundation
///// responsible to fetch from either the data base(realm) or make the service call again, will communicate with the viewModel
//
//class WeatherRepository {
////    private let dataBase: WeatherDataBase
//    private let webService = WeatherServiceAPI() // inject dependency
//    
//    init() {
//        
//    }
//    
//    func fetchWeatherData() -> WeatherResponseModel? {
//        guard let storedDate = UserDefaults.standard.object(forKey: "lastUpdateTime") as? Date else {
//            return fetchWeatherServiceData()
//        }
//        
//        let calendar = Calendar.current
//        
//        if let thirtyMinutesAgo = calendar.date(byAdding: .minute, value: -30, to: Date()),
//           storedDate >= thirtyMinutesAgo {
//            return fetchWeatherFromDatabase()
//        } else {
//            return fetchWeatherServiceData()
//        }
//    }
//    
//   private func fetchWeatherServiceData() -> WeatherResponseModel? {
//       UserDefaults.standard.set(Date(), forKey: "lastUpdateTime")
//       return nil
//    }
//    
//    private func fetchWeatherFromDatabase() -> WeatherResponseModel? {
//        return nil
//    }
//}
