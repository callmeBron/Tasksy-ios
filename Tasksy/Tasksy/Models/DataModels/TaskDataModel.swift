import Foundation
import SwiftUICore

enum TaskStatus: String {
    case inProgress = "inProgress"
    case completed = "completed"
}

enum TaskCategory: String, CaseIterable {
    case work = "work"
    case school = "school"
    case personal = "personal"
    
    var optionColor: Color {
        switch self {
        case .work:
            return .darkBlue
        case .school:
            return .darkPurple
        case .personal:
            return .darkPink
        }
    }
    
    var optionBGColor: Color {
        switch self {
        case .work:
            return .pastelBlue
        case .school:
            return .pastelPurple
        case .personal:
            return .pastelPink
        }
    }
}

struct TaskDataModel: Identifiable {
    let id = UUID()
    let taskTitle: String
    let taskDescription: String
    let taskCategory: TaskCategory
    let taskStatus: TaskStatus
    let taskAction: (() -> Void)?
    
    init(taskTitle: String, taskDescription: String, taskCategory: TaskCategory, taskStatus: TaskStatus, taskAction: (() -> Void)? = nil) {
        self.taskTitle = taskTitle
        self.taskDescription = taskDescription
        self.taskCategory = taskCategory
        self.taskStatus = taskStatus
        self.taskAction = taskAction
    }
}
