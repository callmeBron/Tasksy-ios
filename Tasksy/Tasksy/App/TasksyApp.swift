import SwiftUI
import Swinject

@main
struct TasksyApp: App {
    var container = TaskContainer()
    let taskView = TaskContainer.shared.injectObject(AnyView.self, "TaskView")
    var body: some Scene {
        WindowGroup {
            taskView
        }
    }
}
