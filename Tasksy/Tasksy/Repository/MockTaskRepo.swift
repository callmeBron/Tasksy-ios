import Foundation

protocol TaskRepository {
    func saveTask()
    func fetchTasks() -> [TaskDataModel]
}

class MockTaskRepo: TaskRepository {
    func saveTask() {
        // save the task
    }
    
    func fetchTasks() -> [TaskDataModel] {
        // fetch and map the task
        []
    }
}
