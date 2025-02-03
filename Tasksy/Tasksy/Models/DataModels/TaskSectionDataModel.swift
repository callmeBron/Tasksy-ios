import Foundation

struct TaskSectionDataModel: Identifiable {
    let id = UUID()
    let title: String
    let buttonAction: (() -> Void)?
    let emptySectionTitle: String?
    let tasks: [TaskDataModel]?
    let taskTrailingOptions: [(buttonType: SwipeActionType, buttonAction:() -> Void)]?
    let taskLeadingOptions: [(buttonType: SwipeActionType, buttonAction:() -> Void)]?
    
    init(title: String,
         buttonAction: (() -> Void)? = nil,
         emptySectionTitle: String? = nil,
         tasks: [TaskDataModel]? = nil,
         taskTrailingOptions: [(buttonType: SwipeActionType, buttonAction:() -> Void)]? = nil,
         taskLeadingOptions: [(buttonType: SwipeActionType, buttonAction:() -> Void)]? = nil) {
        self.title = title
        self.buttonAction = buttonAction
        self.emptySectionTitle = emptySectionTitle
        self.tasks = tasks
        self.taskTrailingOptions = taskTrailingOptions
        self.taskLeadingOptions = taskLeadingOptions
    }
}
