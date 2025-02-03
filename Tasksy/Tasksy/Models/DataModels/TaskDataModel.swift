import Foundation
import SwiftUICore

struct TaskDataModel: Identifiable {
    var id: String
    var taskTitle: String
    var taskDescription: String
    var taskCategory: TaskCategory
    var taskStatus: TaskStatus
    
    init(taskTitle: String, taskDescription: String, taskCategory: TaskCategory, taskStatus: TaskStatus) {
        self.id = taskTitle + taskCategory.rawValue + taskDescription
        self.taskTitle = taskTitle
        self.taskDescription = taskDescription
        self.taskCategory = taskCategory
        self.taskStatus = taskStatus
    }
}
