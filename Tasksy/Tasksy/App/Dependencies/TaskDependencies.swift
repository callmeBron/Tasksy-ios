import Foundation
import SwiftUICore
import Swinject

class TaskContainer {
    static let shared = TaskContainer()
    var container: Container
    
    init() {
       container = Container()
        bindDependencies(with: container)
    }
    
    func bindDependencies(with container: Container) {
        container.register(TaskDatabase.self) { _ in
            RealmTaskDatabase()
        }.inObjectScope(.container)
        
        container.register(TaskFormViewModel.self) { (resolver, task: TaskDataModel?) in
            TaskFormViewModel(taskRepository: resolver.resolve(TaskDatabase.self)!,
                              selectedTask: task)
        }.inObjectScope(.transient)
        
        container.register(AnyView.self, name: ObjectNames.TaskObjects.taskFormView) { (resolver, task: TaskDataModel?) in
            AnyView(TaskFormView(viewModel: resolver.resolve(TaskFormViewModel.self,
                                                             argument: task)!))
        }
        
        container.register(TaskViewModel.self) { resolver in
            TaskViewModel(taskRepository: resolver.resolve(TaskDatabase.self)!)
        }
        
        container.register(AnyView.self, name: ObjectNames.TaskObjects.taskView) { resolver in
            AnyView(TaskView(viewModel: resolver.resolve(TaskViewModel.self)!))
        }
    }
    
    func injectObject<T>(_ type: T.Type, _ named: String? = nil) -> T {
        guard let object = container.resolve(type, name: named) else {
            fatalError("Dependency \(type) not registered!")
        }
        return object
    }
    func injectObjectWArg<T>(_ type: T.Type, _ named: String? = nil, _ task: TaskDataModel? = nil) -> T {
        guard let object = container.resolve(type, name: named, argument: task) else {
            fatalError("Dependency \(type) not registered!")
        }
        return object
    }
}

struct ObjectNames {
    struct TaskObjects {
        static let taskFormView = "TaskFormView"
        static let taskView = "TaskView"
    }
}
