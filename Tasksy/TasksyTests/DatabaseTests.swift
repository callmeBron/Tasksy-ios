import XCTest
@testable import Tasksy

final class DatabaseTests: XCTestCase {
    var taskDatabaseUnderTest: TaskDatabase?
    
    override func tearDown() {
        taskDatabaseUnderTest?.clearRealm()
        taskDatabaseUnderTest = nil
        super.tearDown()
    }
    
    func testGivenTheTaskDatabaseWhenPersistingAnItemThenFetchingTheTaskTheExpectedDataIsStored() throws {
        let databaseUnderTest = RealmTaskDatabase()
        let taskObject = TaskDataModel(taskTitle: "Complete Gameboard Challenge",
                                       taskDescription: "Achieve a highscore of 3000",
                                       taskCategory: .personal,
                                       taskStatus: .inProgress)
        taskDatabaseUnderTest?.clearRealm()
        databaseUnderTest.persistTask(task: taskObject)
        let fetchedTasks = databaseUnderTest.fetchTasks()
        
        XCTAssertEqual(fetchedTasks[0].taskTitle, "Complete Gameboard Challenge")
        XCTAssertEqual(fetchedTasks[0].taskDescription, "Achieve a highscore of 3000")
        XCTAssertEqual(fetchedTasks[0].taskCategory, .personal)
        XCTAssertEqual(fetchedTasks[0].taskStatus, .inProgress)
    }
    
    func testGivenTheTaskDatabaseWhenDeletingATaskThenTheTaskDatabaseHasExpectedData() throws {
        let databaseUnderTest = RealmTaskDatabase()
        var taskObject = TaskDataModel(taskTitle: "Go for a Run",
                                       taskDescription: "Train for the next 5km run club event",
                                       taskCategory: .personal,
                                       taskStatus: .inProgress)
        taskDatabaseUnderTest?.clearRealm()
        databaseUnderTest.persistTask(task: taskObject)
        let fetchedTasks = databaseUnderTest.fetchTasks()
        
        XCTAssertEqual(fetchedTasks.last?.taskTitle, "Go for a Run")
        XCTAssertEqual(fetchedTasks.last?.taskDescription, "Train for the next 5km run club event")
        XCTAssertEqual(fetchedTasks.last?.taskCategory, .personal)
        XCTAssertEqual(fetchedTasks[0].taskStatus, .inProgress)
        
        databaseUnderTest.deleteTask(task: taskObject)
        
    }

    func testGivenTheWeatherDatabaseWhenPersistingAnItemThenFetchingTheWeatherTheExpectedDataIsStored() throws {
        let databaseUnderTest = RealmWeatherDatabase()
        let weatherItemToPersist = WeatherResponseModel(location: LocationResponseModel(name: "Sandton", country: "South Africa"),
                                                        current: CurrentWeatherResponseModel(condition: WeatherConditionResponseModel(type: "Sunny"),
                                                                                             tempC: 19.1,
                                                                                             feelslikeC: 30.4,
                                                                                             humidity: 20),
                                                        forecast: ForecastResponseModel(forecastday: [ForecastDayResponseModel(astro: AstroResponseModel(sunrise: "5:12 AM",
                                                                                                                                                         sunset: "9:12 PM"))]))
        
        databaseUnderTest.persistResponse(response: weatherItemToPersist)
        let fetchedWeather = databaseUnderTest.fetch()
        guard let fetchedWeather = fetchedWeather else { XCTFail("Failed to fetch weather from database"); return }
        
        XCTAssertEqual(fetchedWeather.location, "Sandton, South Africa")
        XCTAssertEqual(fetchedWeather.weatherCondition, .sunny)
        XCTAssertEqual(fetchedWeather.tempC, "19.1")
        XCTAssertEqual(fetchedWeather.feelslikeC, "30.4")
        XCTAssertEqual(fetchedWeather.humidity, "20")
        
    }
}
