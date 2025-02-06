import XCTest

final class TasksyUITests: XCTestCase {

    func testWhenCreatingANewTaskThenTheTaskIsAddedToView() throws {
        lauchApp()
       
        createATask()
        
        verifyTextExists(text: "Create a new to do list app")
        verifyTextExists(text: "add extra functionality")
        testTearDown()
    }
    
    func testWhenCompletingANewTaskThenTheTaskIsUpdatedOnView() throws {
        lauchApp()
       
        createATask()
        
        verifyTextExists(text: "Create a new to do list app")
        verifyTextExists(text: "add extra functionality")
        
        swipeRightOnTaskCard()
        tapOnButton(text: "Mark as Complete")
        
        testTearDown()
    }
    
    func testWhenDeletingANewTaskThenTheTaskIsRemovedToView() throws {
        lauchApp()
       
        createATask()
        
        verifyTextExists(text: "Create a new to do list app")
        verifyTextExists(text: "add extra functionality")
        
        swipeLeftOnTaskCard()
        tapOnButton(text: "Delete Task")
        
        veriftyTextDoesNotExist(text: "Create a new to do list app")
        veriftyTextDoesNotExist(text: "add extra functionality")
        
        testTearDown()
    }
    
    func testWhenEditingANewTaskThenTheTaskIsUpdatedOnView() throws {
        lauchApp()
       
        createATask()
        
        verifyTextExists(text: "Create a new to do list app")
        verifyTextExists(text: "add extra functionality")
        
        swipeLeftOnTaskCard()
        tapOnButton(text: "Edit Task")
        
        updateATask()
        
        verifyTextExists(text: "Create a app")
        verifyTextExists(text: "update github")
        
        testTearDown()
    }
    
    private func createATask() {
        tapOnImage(named: "plus.circle.fill")
        tapAndFillTextField(XCUIApplication().textFields["taskTitleTextField"], with: "Create a new to do list app")
        tapAndFillTextField(XCUIApplication().textFields["taskDescriptionTextField"], with: "add extra functionality")
        tapOnButton(text: "Create Task")
    }
    
    private func updateATask() {
        tapAndFillTextField(XCUIApplication().textFields["Task Title"], with: "Create a app")
        tapAndFillTextField(XCUIApplication().textFields["Task Description"], with: "update github")
        tapOnButton(text: "Update Task")
    }
}

