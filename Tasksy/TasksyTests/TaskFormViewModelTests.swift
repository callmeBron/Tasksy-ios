import XCTest
import Combine
@testable import Tasksy

final class TaskFormViewModelTests: XCTestCase {

    func testGivenTheTaskFormViewModelWhenCreatingATaskTheExpectedDataIsSet() throws {
        let viewModelUnderTest = TaskFormViewModel(taskRepository: MockTaskDatabase(),
                                                   selectedTask: nil)
        
        XCTAssertEqual(viewModelUnderTest.viewTitle,  "Create a New Task")
        XCTAssertEqual(viewModelUnderTest.buttonTitle,  "Create Task")
        XCTAssertNil(viewModelUnderTest.selectedTask)
        XCTAssertEqual(viewModelUnderTest.title, "")
        XCTAssertEqual(viewModelUnderTest.description, "")
        XCTAssertEqual(viewModelUnderTest.category, .personal)
    }
    
    func testGivenTheTaskFormViewModelWhenEditingATaskTheExpectedDataIsSet() throws {
        let selectedTask = TaskDataModel(taskTitle: "Go through the math module",
                                         taskDescription: "undertand linear algebra",
                                         taskCategory: .school,
                                         taskStatus: .inProgress)
        let viewModelUnderTest = TaskFormViewModel(taskRepository: MockTaskDatabase(),
                                                   selectedTask: selectedTask)
        
        XCTAssertEqual(viewModelUnderTest.viewTitle,  "Edit Task")
        XCTAssertEqual(viewModelUnderTest.buttonTitle,  "Update Task")
        XCTAssertNotNil(viewModelUnderTest.selectedTask)
        XCTAssertEqual(viewModelUnderTest.title, "Go through the math module")
        XCTAssertEqual(viewModelUnderTest.description, "undertand linear algebra")
        XCTAssertEqual(viewModelUnderTest.category, .school)
    }
}

private class MockTaskDatabase: TaskDatabase {
    var taskUpdateNotifier = PassthroughSubject<ResultState, Never>()
    
    func fetchTasks() -> [TaskDataModel] {
        taskUpdateNotifier.send(.success)
        return []
    }
    
    func persistTask(task: TaskDataModel) {
        // not necessary
    }
    
    func updateTask(updatedValues: TaskDataModel, selectedTask: TaskDataModel) {
        // not necessary
    }
    
    func deleteTask(task: TaskDataModel) {
        // not necessary
    }
    
    func clearRealm() {
        // not necessary
    }
}
