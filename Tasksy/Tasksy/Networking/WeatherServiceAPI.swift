import Foundation


protocol WeatherServiceAPI {
    func fetchWeatherInformation() async -> Result<WeatherResponseModel, ErrorResponse>
}

class WeatherService: WeatherServiceAPI {
    let locationProvider = LocationInfoProvider()
    
    func fetchWeatherInformation() async -> Result<WeatherResponseModel, ErrorResponse> {
        let apiKey = "dbaee37b61424c2ea86120113250402"
        let area = "\(String(locationProvider.latitude ?? 0.0)),\(String(locationProvider.longitude ?? 0.0))"
        let endpoint = "https://api.weatherapi.com/v1/forecast.json?key=\(apiKey)&q=\(area)"
        
        guard let url = URL(string: endpoint) else {
            return .failure(ErrorResponse(errorReason: "Invalid Endpoint Reached",
                                          errorMessage: "Looks like we've recieved an unexpected Error"))
        }
        
        return await withCheckedContinuation { continuation in
            URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
                if let error = error {
                    continuation.resume(returning: .failure(ErrorResponse(errorReason: "Network Error",
                                                                          errorMessage: error.localizedDescription)))
                    return
                }
                
                guard let data = data else {
                    continuation.resume(returning: .failure(ErrorResponse(errorReason: "Data error",
                                                                          errorMessage: "Unfortunately we have not received data")))
                    return
                }
                
                do {
                    let weatherData = try JSONDecoder().decode(WeatherResponseModel.self, from: data)
                    continuation.resume(returning: .success(weatherData))
                } catch {
                    continuation.resume(returning: .failure(ErrorResponse(errorReason: "Failed To Decode Data",
                                                                          errorMessage: "We were unable to decode the data \(error.localizedDescription)")))
                }
            }
            .resume()
        }
    }
}
