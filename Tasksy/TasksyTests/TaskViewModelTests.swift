import XCTest
import Combine
@testable import Tasksy

final class TaskViewModelTests: XCTestCase {
  
    func testGivenTheTaskViewModelWhenReceivingDataThenTheCorrectDataIsSet() throws {
        let viewModelUnderTest = TaskViewModel(taskRepository: MockTaskDatabase())
        viewModelUnderTest.fetch()
        
        XCTAssertEqual(viewModelUnderTest.dataModel?.taskSections.count, 2)
        XCTAssertEqual(viewModelUnderTest.dataModel?.taskSections[0].tasks?.count, 2)
        XCTAssertEqual(viewModelUnderTest.dataModel?.taskSections[1].tasks?.count, 1)
    }
}

private class MockTaskDatabase: TaskDatabase {
    var taskUpdateNotifier = PassthroughSubject<ResultState, Never>()
    
    init() {
        taskUpdateNotifier.send(.success)
    }
    
    func fetchTasks() -> [TaskDataModel] {
        return [TaskDataModel(taskTitle: "Run a 5km",
                              taskDescription: "at least jog for most of it",
                              taskCategory: .personal,
                              taskStatus: .inProgress),
                TaskDataModel(taskTitle: "Read up on Redux pattern",
                              taskDescription: "Complete the Architecture course",
                              taskCategory: .work,
                              taskStatus: .inProgress),
                TaskDataModel(taskTitle: "Complete the dissertation",
                              taskDescription: "Spend an hour on the work",
                              taskCategory: .school,
                              taskStatus: .completed)]
    }
    
    func persistTask(task: TaskDataModel) {
        // not necessary to fill
    }
    
    func updateTask(updatedValues: TaskDataModel, selectedTask: TaskDataModel) {
        // not necessary to fill
    }
    
    func deleteTask(task: TaskDataModel) {
        // not necessary to fill
    }
    
    func clearRealm() {
        // not necessary to fill
    }
}
