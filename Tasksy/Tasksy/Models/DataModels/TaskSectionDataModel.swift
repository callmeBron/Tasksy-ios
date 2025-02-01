import Foundation

struct TaskSectionDataModel: Identifiable {
    let id = UUID()
    let title: String
    let emptySectionTitle: String?
    let tasks: [TaskDataModel]?
    
    init(title: String, emptySectionTitle: String? = nil, tasks: [TaskDataModel]? = nil) {
        self.title = title
        self.emptySectionTitle = emptySectionTitle
        self.tasks = tasks
    }
}
