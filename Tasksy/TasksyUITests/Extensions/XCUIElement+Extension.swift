import XCTest

extension XCUIElement {
    func clearText() {
        guard let existingText = self.value as? String else { return }
        self.tap()
        self.doubleTap()
        let stringToDelete = String(repeating: XCUIKeyboardKey.delete.rawValue, count: existingText.count)
        typeText(stringToDelete)
    }
}
