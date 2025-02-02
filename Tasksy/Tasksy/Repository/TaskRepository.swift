import Foundation
import Combine
import RealmSwift

protocol TaskRepository {
    var taskRealmPublisher: PassthroughSubject<ResultState, Never> { get }
    func fetchTasks() -> [TaskDataModel]
    func persistTask(task: TaskDataModel)
    func updateTask(task: TaskDataModel)
    func deleteTask(task: TaskDataModel)
}

class ConcreteTaskRepository: TaskRepository {
    private(set) var taskRealm: Realm?
    var taskRealmPublisher: PassthroughSubject<ResultState, Never> = PassthroughSubject<ResultState, Never>()
    
    init() {
        setupRealm()
    }
    
    private func setupRealm() {
        do {
            let configurationSetup = Realm.Configuration(schemaVersion: 1)
            Realm.Configuration.defaultConfiguration = configurationSetup
            taskRealm = try Realm()
        } catch {
            taskRealmPublisher.send(.error(title: "Failed To Get Tasks", message: "We were unable to retrieve your task."))
        }
    }
    
    func persistTask(task: TaskDataModel) {
        guard let taskRealm else { return }
        do {
            try taskRealm.write {
                let newTask = TasksPersistedDataModel(dataModel: task)
                taskRealm.add(newTask)
                taskRealmPublisher.send(.success)
            }
        } catch {
            taskRealmPublisher.send(.error(title: "Task Creation Failed", message: "We were unable to save your task."))
        }
    }
    
    func updateTask(task: TaskDataModel) {
        guard let taskRealm else { return }
        guard let taskToUpdate = taskRealm.objects(TaskPersistedDataModel.self).first(where: { $0.taskID == task.id }) else { return }
        do {
            try taskRealm.write {
                taskToUpdate.taskStatus = "completed"
                taskRealmPublisher.send(.success)
            }
        } catch {
            taskRealmPublisher.send(.error(title: "Failed To Update Task", message: "We were unable to update your task."))
        }
    }
    
    func deleteTask(task: TaskDataModel) {
        guard let taskRealm else { return }
        guard let selectedTask = taskRealm.objects(TaskPersistedDataModel.self).first(where: { $0.taskID == task.id }) else { return }

        do {
            try taskRealm.write {
                taskRealm.delete(selectedTask)
                taskRealmPublisher.send(.success)
            }
        } catch {
            taskRealmPublisher.send(.error(title: "Failed To Delete Task", message: "We were unable to delete your task."))
        }
    }
    
    func fetchTasks() -> [TaskDataModel] {
        guard let taskRealm else { return [] }
        return taskRealm.objects(TasksPersistedDataModel.self)
            .flatMap { $0.tasks }
            .map {
                TaskDataModel(taskTitle: $0.taskTitle,
                              taskDescription: $0.taskDescription,
                              taskCategory: TaskCategory(rawValue: $0.taskCategory) ?? .personal,
                              taskStatus: TaskStatus(rawValue: $0.taskStatus) ?? .inProgress)
            }
    }
}
