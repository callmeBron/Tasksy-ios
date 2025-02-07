import XCTest

final class TasksyUITests: XCTestCase {
    
    func testWhenCreatingANewTaskThenTheTaskIsAddedToView() throws {
        uninstallApp(name: "Tasksy")
        lauchApp()
        
        createATask()
        
        verifyTextExists(text: "Create a new to do list app")
        verifyTextExists(text: "add extra functionality")
        verifyTextExists(text: "No Completed Tasks")
        
        testTearDown()
    }
    
    func testWhenCompletingANewTaskThenTheTaskIsUpdatedOnView() throws {
        uninstallApp(name: "Tasksy")
        lauchApp()
        
        createATask()
        
        verifyTextExists(text: "Create a new to do list app")
        verifyTextExists(text: "add extra functionality")
        verifyTextExists(text: "No Completed Tasks")
        
        swipeRightOnTaskCard()
        tapOnButton(text: "Mark as Completed")
        verifyTextExists(text: "Create a Task")
        
        testTearDown()
        
    }
    
    func testWhenDeletingANewTaskThenTheTaskIsRemovedToView() throws {
        uninstallApp(name: "Tasksy")
        lauchApp()
        
        createATask()
        
        verifyTextExists(text: "Create a new to do list app")
        verifyTextExists(text: "add extra functionality")
        
        swipeLeftOnTaskCard()
        tapOnButton(text: "Delete Task")
        
        tapOnAlertDelete()
        
        verifyTextExists(text: "Create a Task")
        
        testTearDown()
    }
    
    func testWhenEditingANewTaskThenTheTaskIsUpdatedOnView() throws {
        uninstallApp(name: "Tasksy")
        lauchApp()
        
        createATask()
        
        verifyTextExists(text: "Create a new to do list app")
        verifyTextExists(text: "add extra functionality")
        
        swipeLeftOnTaskCard()
        tapOnButton(text: "Edit Task")
        
        updateATask()

        verifyTextExists(text: "update github")
        
        testTearDown()
    }
    
    private func updateATask() {
        clearTextField(named: "Task Title")
        tapAndFillTextField(XCUIApplication().textFields["Task Title"], with: "Create a app")
        clearTextField(named: "Task Description")
        tapAndFillTextField(XCUIApplication().textFields["Task Description"], with: "update github")
        tapOnButton(text: "Update Task")
    }
    
    private func createATask() {
        tapOnButton(text: "taskAddButton")
        tapAndFillTextField(XCUIApplication().textFields["taskTitleTextField"], with: "Create a new to do list app")
        tapAndFillTextField(XCUIApplication().textFields["taskDescriptionTextField"], with: "add extra functionality")
        tapOnButton(text: "Create Task")
    }
}

