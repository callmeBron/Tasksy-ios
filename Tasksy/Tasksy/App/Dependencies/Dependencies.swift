import Foundation
import SwiftUICore
import Swinject

class DependencyContainer {
    static let shared = DependencyContainer()
    var container: Container
    
    init() {
       container = Container()
        bindDependencies(with: container)
    }
    
    func bindDependencies(with container: Container) {
        /// Weather Features

        container.register(WeatherDatabase.self) { _ in
            RealmWeatherDatabase()
        }.inObjectScope(.container)
        
        container.register(WeatherServiceAPI.self) { resolver in
            WeatherService()
        }
        
        container.register(WeatherRepository.self) { resolver in
            ConcreteWeatherRepository(dataBase: resolver.resolve(WeatherDatabase.self)!,
                                      webService: resolver.resolve(WeatherServiceAPI.self)!)
        }
        
        container.register(WeatherViewModel.self) { resolver in
            WeatherViewModel(weatherRepository: resolver.resolve(WeatherRepository.self)!)
        }
        
        container.register(AnyView.self, name: ObjectNames.TaskObjects.weatherView) { resolver in
            AnyView(WeatherView(viewModel:resolver.resolve(WeatherViewModel.self)!))
        }
        
        /// Task Features
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
        static let weatherView = "WeatherView"
    }
}
