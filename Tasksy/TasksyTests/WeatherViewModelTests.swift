import XCTest
@testable import Tasksy

final class WeatherViewModelTests: XCTestCase {
    
    func testGivenTheWeatherViewModelWhenTheResponseIsUnSuccessfulThenTheErrorIsSet() throws {
        let viewModelUnderTest = WeatherViewModel(weatherRepository: MockRepository(isSuccessful: false))
        XCTAssertEqual(viewModelUnderTest.dataModel?.errorData?.errorReason, "Unfortunately we have got an error")
        XCTAssertEqual(viewModelUnderTest.dataModel?.errorData?.errorMessage, "There has been an unforseen error")
    }
    
    func testGivenTheWeatherViewModelWhenTheResponseIsSuccessfulThenTheWeatherIsSet() throws {
        let viewModelUnderTest = WeatherViewModel(weatherRepository: MockRepository(isSuccessful: true))
        XCTAssertEqual(viewModelUnderTest.dataModel?.weatherData?.location, "South Africa")
        XCTAssertEqual(viewModelUnderTest.dataModel?.weatherData?.weatherCondition, .sunny)
        XCTAssertEqual(viewModelUnderTest.dataModel?.weatherData?.tempC, "18")
        XCTAssertEqual(viewModelUnderTest.dataModel?.weatherData?.feelslikeC, "19")
        XCTAssertEqual(viewModelUnderTest.dataModel?.weatherData?.humidity, "20")
    }
}

private class MockRepository: WeatherRepository {
    var isSuccessful: Bool
    
    init(isSuccessful: Bool) {
        self.isSuccessful = isSuccessful
    }
    
    func fetchWeatherData() async -> (weatherData: WeatherDataModel?, error: ErrorResponse?) {
        if isSuccessful {
            return (WeatherDataModel(location: "South Africa",
                                     sunriseTime: "4:00 am",
                                     sunsetTime: "19:03 pm",
                                     weatherCondition: .sunny,
                                     tempC: "18",
                                     feelslikeC: "19",
                                     humidity: "20"),
                    nil)
        } else {
            return (nil, ErrorResponse(errorReason: "Unfortunately we have got an error",
                                       errorMessage: "There has been an unforseen error"))
        }
    }
}
