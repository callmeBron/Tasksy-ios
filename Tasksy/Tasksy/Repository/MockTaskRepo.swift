import Foundation

protocol TaskRepository {
    func saveTask()
    func removeTask()
    func fetchTasks() -> [TaskDataModel]
}

class MockTaskRepo: TaskRepository {
    func removeTask() {
        // removal of tasks
    }
    
    func saveTask() {
        // save the task
    }
    
    func fetchTasks() -> [TaskDataModel] {
        // fetch and map the task
        []
    }
}
