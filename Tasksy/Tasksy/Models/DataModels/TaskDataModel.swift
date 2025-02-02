import Foundation
import SwiftUICore

struct TaskDataModel: Identifiable {
    let id: String
    let taskTitle: String
    let taskDescription: String
    let taskCategory: TaskCategory
    let taskStatus: TaskStatus
    let taskAction: (() -> Void)?
    
    init(taskTitle: String, taskDescription: String, taskCategory: TaskCategory, taskStatus: TaskStatus, taskAction: (() -> Void)? = nil) {
        self.id = taskTitle + taskCategory.rawValue + taskDescription
        self.taskTitle = taskTitle
        self.taskDescription = taskDescription
        self.taskCategory = taskCategory
        self.taskStatus = taskStatus
        self.taskAction = taskAction
    }
}
