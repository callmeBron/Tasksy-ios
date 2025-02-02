import Foundation
import Combine

class TaskViewModel: ObservableObject {
    @Published var dataModel: TaskViewDataModel?
    private var taskCancellable: AnyCancellable?
    private let taskRepository: TaskRepository // ConcreteTaskRepository
    
    private var fetchedTasks: [TaskDataModel] {
        return taskRepository.fetchTasks()
    }
    
    init(taskRepository: TaskRepository) {
        self.taskRepository = taskRepository
        setUpRepositoryListener()
        fetch()
    }
    
    private func setUpRepositoryListener() {
        taskCancellable = taskRepository.taskRealmPublisher?.sink(receiveValue: { [weak self] _ in
            self?.fetch()
        })
    }
    
    private func fetch() {
        dataModel = TaskViewDataModel(secondaryButtonAction: { print("will show the weather view") },
                                      taskSections: [createToDoSection(),
                                                     createCompletedSection()])
    }
    
    private func createToDoSection() -> TaskSectionDataModel {
        let currentTasks = fetchedTasks.filter({ $0.taskStatus == .inProgress })
        let emptyTasks = currentTasks.count == 0
        return TaskSectionDataModel(title: "To do",
                                    buttonAction: { print("add task button") }, // send the view
                                    emptySectionTitle: emptyTasks ? "Create a Task" : nil,
                                    tasks: emptyTasks ? nil : currentTasks)
    }
    
    private func createCompletedSection() -> TaskSectionDataModel {
        let completedTasks = fetchedTasks.filter({ $0.taskStatus == .completed })
        let emptyTasks = completedTasks.count == 0
        return TaskSectionDataModel(title: "Completed Tasks",
                                    emptySectionTitle: emptyTasks ? "No Completed Tasks" : nil,
                                    tasks: emptyTasks ? nil : completedTasks)
    }
}
