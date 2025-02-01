import Foundation

class TaskViewModel: ObservableObject {
    @Published var dataModel: TaskViewDataModel?
    private let taskRepository: TaskRepository
    
    init(taskRepository: TaskRepository) {
        self.taskRepository = taskRepository
        fetch()
    }
    
    private func fetch() {
        let currentTasks = [TaskDataModel(taskTitle: "Work on SwiftUI",
                                          taskDescription: "Create views for assessment",
                                          taskCategory: .work,
                                          taskStatus: .inProgress,
                                          taskAction: {
            print("task action")
        }),
                            TaskDataModel(taskTitle: "Eat Lunch",
                                          taskDescription: "Invite some people over",
                                          taskCategory: .personal,
                                          taskStatus: .inProgress,
                                          taskAction: {
            print("task action")
        })]
        
        let todoSection = TaskSectionDataModel(title: "To do", tasks: currentTasks)
        let completedSection = TaskSectionDataModel(title: "Completed",
                                                    emptySectionTitle: "There are currently no completed tasks")
        
        dataModel = TaskViewDataModel(secondaryButtonAction: { print("will show the weather view") },
                                      taskSections: [todoSection, completedSection])
    }
}
