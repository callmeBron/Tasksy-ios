import Foundation

struct TaskSectionDataModel: Identifiable {
    let id = UUID()
    let title: String
    let buttonAction: (() -> Void)?
    let emptySectionTitle: String?
    let tasks: [TaskDataModel]?
    
    init(title: String, buttonAction: (() -> Void)? = nil, emptySectionTitle: String? = nil, tasks: [TaskDataModel]? = nil) {
        self.title = title
        self.buttonAction = buttonAction
        self.emptySectionTitle = emptySectionTitle
        self.tasks = tasks
    }
}
