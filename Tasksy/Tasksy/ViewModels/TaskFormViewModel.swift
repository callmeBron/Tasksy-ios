import Foundation

class TaskFormViewModel: ObservableObject {
    @Published var title: String = ""
    @Published var description: String = ""
    @Published var category = TaskCategory.personal
    var viewTitle: String = ""
    var buttonTitle: String = ""
    var buttonAction: (() -> Void)?
    
    let taskOptions = TaskCategory.allCases
    let selectedTask: TaskDataModel?
    
    private let taskRepository: TaskDatabase
    
    init(taskRepository: TaskDatabase, selectedTask: TaskDataModel? = nil) {
        self.taskRepository = taskRepository
        self.selectedTask = selectedTask
        selectedTask != nil ?  setEditView() :  setCreateView()
    }

    func setCreateView() {
        viewTitle = "Create a New Task"
        buttonTitle = "Create Task"
        buttonAction = { [weak self] in
            self?.saveTask()
        }
    }
    
    func setEditView() {
        guard let selectedTask else { return }
        title = selectedTask.taskTitle
        description = selectedTask.taskDescription
        category = selectedTask.taskCategory
        viewTitle = "Edit Task"
        buttonTitle = "Update Task"
        buttonAction = { [weak self] in
            self?.updateTask()
        }
    }
    
    func updateTask() {
        guard let selectedTask else { return }
        let task = TaskDataModel(taskTitle: title,
                                 taskDescription: description,
                                 taskCategory: category,
                                 taskStatus: .inProgress)
        taskRepository.updateTask(updatedValues: task,
                                  selectedTask: selectedTask)
    }
    
    func saveTask() {
        let task = TaskDataModel(taskTitle: title,
                                 taskDescription: description,
                                 taskCategory: category,
                                 taskStatus: .inProgress)
        taskRepository.persistTask(task: task)
    }
}
