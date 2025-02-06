import Foundation
import Combine
import RealmSwift

protocol TaskDatabase {
    var taskUpdateNotifier: PassthroughSubject<ResultState, Never> { get }
    func fetchTasks() -> [TaskDataModel]
    func persistTask(task: TaskDataModel)
    func updateTask(updatedValues: TaskDataModel, selectedTask: TaskDataModel)
    func deleteTask(task: TaskDataModel)
    func clearRealm()
}

class RealmTaskDatabase: TaskDatabase {
    private(set) var taskRealm: Realm?
    var taskUpdateNotifier: PassthroughSubject<ResultState, Never> = PassthroughSubject<ResultState, Never>()
    
    init() {
        setupRealm()
    }
    
    private func setupRealm() {
        do {
            let configurationSetup = Realm.Configuration(schemaVersion: 1)
            Realm.Configuration.defaultConfiguration = configurationSetup
            taskRealm = try Realm()
        } catch {
            taskUpdateNotifier.send(.error(title: "Failed To Get Tasks", message: "We were unable to retrieve your task."))
        }
    }
    
    func persistTask(task: TaskDataModel) {
        guard let taskRealm else { return }
        do {
            try taskRealm.write {
                let newTask = TasksPersistedDataModel(dataModel: task)
                taskRealm.add(newTask)
                taskUpdateNotifier.send(.success)
            }
        } catch {
            taskUpdateNotifier.send(.error(title: "Task Creation Failed", message: "We were unable to save your task."))
        }
    }
    
    func updateTask(updatedValues: TaskDataModel, selectedTask: TaskDataModel) {
        guard let taskRealm else { return }
        guard let taskToUpdate = taskRealm.objects(TaskPersistedDataModel.self).first(where: { $0.taskID == selectedTask.id }) else { return }
        do {
            try taskRealm.write {
                taskToUpdate.taskID = updatedValues.id
                taskToUpdate.taskTitle = updatedValues.taskTitle
                taskToUpdate.taskDescription = updatedValues.taskDescription
                taskToUpdate.taskCategory = updatedValues.taskCategory.rawValue
                taskToUpdate.taskStatus = updatedValues.taskStatus.rawValue
                taskUpdateNotifier.send(.success)
            }
        } catch {
            taskUpdateNotifier.send(.error(title: "Failed To Update Task", message: "We were unable to update your task."))
        }
    }
    
    func deleteTask(task: TaskDataModel) {
        guard let taskRealm else { return }
        guard let taskToDelete = taskRealm.objects(TaskPersistedDataModel.self).first(where: { $0.taskID == task.id }) else { return }
        do {
            try taskRealm.write {
                taskRealm.delete(taskToDelete)
                taskUpdateNotifier.send(.success)
            }
        } catch {
            taskUpdateNotifier.send(.error(title: "Failed To Delete Task", message: "We were unable to delete your task."))
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
    
    func clearRealm() {
        guard let taskRealm else { return }
        do {
            try taskRealm.write {
                taskRealm.deleteAll()
            }
        } catch let error {
            taskUpdateNotifier.send(.error(title: "Failed To Delete Task", message: "We were unable to delete your task."))
        }
    }
}
