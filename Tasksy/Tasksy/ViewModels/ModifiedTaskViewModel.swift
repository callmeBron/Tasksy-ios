import Foundation

class ModifiedTaskViewModel: ObservableObject {
    @Published var title: String = ""
    @Published var description: String = ""
    @Published var category = TaskCategory.personal
    let taskOptions = TaskCategory.allCases
    
    private let taskRepository: TaskRepository
    
    init(taskRepository: TaskRepository) {
        self.taskRepository = taskRepository
    }
    
    func buttonAction() {
        let task = TaskDataModel(taskTitle: title,
                                 taskDescription: description,
                                 taskCategory: category,
                                 taskStatus: .inProgress)
        taskRepository.persistTask(task: task)
    }
}
