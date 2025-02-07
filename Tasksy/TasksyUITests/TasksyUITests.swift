import XCTest

final class TasksyUITests: XCTestCase {

    func testWhenCreatingANewTaskThenTheTaskIsAddedToView() throws {
        lauchApp()
       
        createATask()
        
        verifyTextExists(text: "Create a new to do list app")
        verifyTextExists(text: "add extra functionality")
        
        testTearDown()
    }
    
    private func createATask() {
        tapOnButton(text: "taskAddButton")
        tapAndFillTextField(XCUIApplication().textFields["taskTitleTextField"], with: "Create a new to do list app")
        tapAndFillTextField(XCUIApplication().textFields["taskDescriptionTextField"], with: "add extra functionality")
        tapOnButton(text: "Create Task")
    }
}

