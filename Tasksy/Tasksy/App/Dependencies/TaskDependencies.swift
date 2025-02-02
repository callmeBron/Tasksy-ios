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
        container.register(TaskRepository.self) { _ in
            ConcreteTaskRepository()
        }.inObjectScope(.container)
        
        container.register(ModifiedTaskViewModel.self) { resolver in
            ModifiedTaskViewModel(taskRepository: resolver.resolve(TaskRepository.self)!)
        }
        
        container.register(ModifiedTaskViewModel.self) { resolver in
            ModifiedTaskViewModel(taskRepository: resolver.resolve(TaskRepository.self)!)
        }
        
        container.register(AnyView.self, name: "TaskModifierView") { resolver in
            AnyView(ModifyTaskView(viewModel: resolver.resolve(ModifiedTaskViewModel.self)!))
        }
        
        container.register(TaskViewModel.self) { resolver in
            TaskViewModel(taskRepository: resolver.resolve(TaskRepository.self)!)
        }
        
        container.register(AnyView.self, name: "TaskView") { resolver in
            AnyView(TaskView(viewModel: resolver.resolve(TaskViewModel.self)!))
        }
    }
    
    func injectObject<T>(_ type: T.Type, _ named: String? = nil) -> T {
        guard let object = container.resolve(type, name: named) else {
            fatalError("Dependency \(type) not registered!")
        }
        return object
    }
}
