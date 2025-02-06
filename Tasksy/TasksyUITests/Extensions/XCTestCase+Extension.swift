import XCTest

extension XCTestCase {
    func lauchApp() {
        if self.appIsInstalled(timeout: 5) {
            uninstallApp(name: "Tasksy")
        }
        let app = XCUIApplication()
        app.launch()
    }
    
    func testTearDown() {
        addTeardownBlock { [self] in
            let app = XCUIApplication(bundleIdentifier: "com.b.dos.santos.Tasksy")
            app.terminate()
            if self.appIsInstalled(timeout: 5) {
                uninstallApp(name: "Tasksy")
            }
        }
    }
    
    func tapOnImage(named: String){
        tapOnElement(element: XCUIApplication().images[named])
    }
    
    func tapOnElement(element: XCUIElement) {
        if (element.waitForExistence(timeout: 30)){
            element.tap()
        } else {
            XCTFail("Could not find element")
        }
    }
    
    func tapAndFillTextField(_ textField: XCUIElement, with text: String) {
        textField.tap()
        textField.typeText(text)
    }
    
    func tapOnButton(text: String) {
        tapOnElement(element: XCUIApplication().buttons[text])
    }
    
    func verifyTextExists(text: String) {
        let givenText = XCUIApplication().staticTexts.element(matching: NSPredicate(format: "label == %@", text))
        XCTAssertTrue(givenText.waitForExistence(timeout: 30))
    }
    
    func veriftyTextDoesNotExist(text: String) {
        let givenText = XCUIApplication().staticTexts.element(matching: NSPredicate(format: "label == %@", text))
        XCTAssertFalse(givenText.waitForExistence(timeout: 30))
    }
    
    func swipeRightOnTaskCard() {
        let row = XCUIApplication().tables.cells["task row"]
        row.swipeRight()
    }
    
    func swipeLeftOnTaskCard() {
        let row = XCUIApplication().tables.cells["task row"]
        row.swipeLeft()
    }

    private func appIsInstalled(timeout: TimeInterval) -> Bool {
        let appIdentifier = "Tasksy"
        let springboard = XCUIApplication(bundleIdentifier: "com.b.dos.santos.Tasksy")
        let appIcon = springboard.icons[appIdentifier]
        let existsPredicate = NSPredicate(format: "exists == true")
        let hittablePredicate = NSPredicate(format: "isHittable == true")
        let expectation = XCTNSPredicateExpectation(predicate: NSCompoundPredicate(andPredicateWithSubpredicates: [existsPredicate, hittablePredicate]), object: appIcon)
        let result = XCTWaiter().wait(for: [expectation], timeout: timeout)
        return result == .completed
    }
    
    private func uninstallApp(name: String? = nil) {
        XCUIApplication().terminate()
        
        let timeout = TimeInterval(5)
        let springboard = XCUIApplication(bundleIdentifier: "com.apple.springboard")
        
        let appName: String
        
        if let name = name {
            appName = name
        } else {
            let uiTestname = Bundle.main.infoDictionary?["CFBundleName"] as? String ?? ""
            appName = uiTestname.replacingOccurrences(of: "UITests-Runner", with: "")
        }
        
        let appIcon = springboard.icons[appName].firstMatch
        if appIcon.waitForExistence(timeout: timeout) {
            appIcon.press(forDuration: 1)
        } else  {
            XCTFail("failed to find \(appName)")
        }
        
        let removeButton = springboard.buttons["Remove App"]
        if removeButton.waitForExistence(timeout: timeout) {
            removeButton.tap()
        }
        
        let deleteAppButton = springboard.buttons["Delete App"]
        if deleteAppButton.waitForExistence(timeout: timeout) {
            deleteAppButton.tap()
        }
        
        let deleteConfirmationButton = springboard.buttons["Delete"]
        if deleteConfirmationButton.waitForExistence(timeout: timeout) {
            deleteConfirmationButton.tap()
        }
    }
}
