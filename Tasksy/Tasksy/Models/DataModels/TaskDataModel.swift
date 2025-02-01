import Foundation

enum TaskStatus: String {
    case inProgress = "inProgress"
    case completed = "completed"
}

enum TaskCategory: String, CaseIterable {
    case work = "work"
    case school = "school"
    case personal = "personal"
}

struct TaskDataModel: Identifiable {
    let id = UUID()
    let taskTitle: String
    let taskDescription: String
    let taskCategory: TaskCategory
    let taskStatus: TaskStatus
    let taskAction: (() -> Void)
    
    init(taskTitle: String, taskDescription: String, taskCategory: TaskCategory, taskStatus: TaskStatus, taskAction: @escaping () -> Void) {
        self.taskTitle = taskTitle
        self.taskDescription = taskDescription
        self.taskCategory = taskCategory
        self.taskStatus = taskStatus
        self.taskAction = taskAction
    }
}
