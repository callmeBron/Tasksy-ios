import Foundation
import SwiftUICore

struct TaskViewDataModel {
    var notificationBanner: (title: String, message: String)?
    var secondaryButtonAction: (() -> Void)
    var taskSections: [TaskSectionDataModel]

    init(notificationBanner: (title: String, message: String)? = nil,
         secondaryButtonAction: @escaping () -> Void,
         taskSections: [TaskSectionDataModel]) {
        self.notificationBanner = notificationBanner
        self.secondaryButtonAction = secondaryButtonAction
        self.taskSections = taskSections
    }
}
