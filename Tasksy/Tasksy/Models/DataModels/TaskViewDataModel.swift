import Foundation

struct TaskViewDataModel {
    let secondaryButtonAction: (() -> Void)
    let taskSections: [TaskSectionDataModel]
    
    init(secondaryButtonAction: @escaping () -> Void, taskSections: [TaskSectionDataModel]) {
        self.secondaryButtonAction = secondaryButtonAction
        self.taskSections = taskSections
    }
}
