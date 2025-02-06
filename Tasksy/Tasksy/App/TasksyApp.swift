import SwiftUI
import Swinject

@main
struct TasksyApp: App {
    var container = DependencyContainer()
    let locationManager = LocationManager()
    
    let taskView = DependencyContainer.shared.injectObject(AnyView.self, ObjectNames.TaskObjects.taskView)
    var body: some Scene {
        WindowGroup {
            taskView
        }
    }
}
