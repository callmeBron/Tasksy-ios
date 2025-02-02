import Foundation
import Combine
import RealmSwift

protocol TaskRepository {
    var taskRealmPublisher: PassthroughSubject<Bool, Never>? { get }
    func persistTask(task: TaskDataModel)
    func removeTask()
    func fetchTasks() -> [TaskDataModel]
}

class ConcreteTaskRepository: TaskRepository {
    private(set) var taskRealm: Realm?
    var taskRealmPublisher: PassthroughSubject<Bool, Never>?
    
    init() {
        setupRealm()
    }
    
    private func setupRealm() {
        do {
            let configurationSetup = Realm.Configuration(schemaVersion: 1)
            Realm.Configuration.defaultConfiguration = configurationSetup
            taskRealm = try Realm()
        } catch {
            // send an error to inform that we are unable to create a realm
        }
    }
    
    func persistTask(task: TaskDataModel) {
        guard let taskRealm else { return } // return error
        do {
            try taskRealm.write {
                let newTask = TasksPersistedDataModel(dataModel: task)
                taskRealm.add(newTask)
                taskRealmPublisher?.send(true)
            }
        } catch {
            // send an error to inform that we are unable to save a task
        }
    }
    
    func removeTask() {
        // removal of tasks
    }
    
    func fetchTasks() -> [TaskDataModel] {
        guard let taskRealm else { return [] } // return error

        let persistedTasks = taskRealm.objects(TasksPersistedDataModel.self)
        var currentTasks: [TaskDataModel] = []

        for persistedTaskObject in persistedTasks {
            for task in persistedTaskObject.tasks {
                let taskDataModel = TaskDataModel(
                    taskTitle: task.taskTitle,
                    taskDescription: task.description,
                    taskCategory: TaskCategory(rawValue: task.taskCategory) ?? .personal,
                    taskStatus: TaskStatus(rawValue: task.taskStatus) ?? .inProgress
                )
                currentTasks.append(taskDataModel)
            }
        }
        
        return currentTasks
    }
}
