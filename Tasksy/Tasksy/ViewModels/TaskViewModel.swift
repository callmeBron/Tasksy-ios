import Foundation
import SwiftUI
import SwiftUICore
import Combine

class TaskViewModel: ObservableObject {
    @Published var dataModel: TaskViewDataModel?
    
    @Published var shouldShowEditView: Bool = false
    @Published var showCreateTaskView: Bool = false
    @Published var showDeleteConfirmation: Bool = false
    
    private var taskCancellable: AnyCancellable?
    private let taskRepository: TaskDatabase
    
    private var fetchedTasks: [TaskDataModel] {
        return taskRepository.fetchTasks()
    }
    
    var selectedTask: TaskDataModel?
    
    init(taskRepository: TaskDatabase) {
        self.taskRepository = taskRepository
        setUpRepositoryListener()
        fetch()
    }
    
    private func setUpRepositoryListener() {
        taskCancellable = taskRepository.taskUpdateNotifier.sink(receiveValue: { [weak self] resultState in
            switch resultState {
            case .success:
                
                self?.fetch()
            case .error(let title, let message):
                self?.setErrorBanner(with: (title, message))
            }
        })
    }
    
    func showCreateView() {
        showCreateTaskView.toggle()
    }
    
    private func showDeletionConfirmation() {
        showDeleteConfirmation.toggle()
    }
    
    func fetch() {
        setDataModel()
    }
    
    private func setErrorBanner(with content: (title: String, message: String)) {
        dataModel?.notificationBanner = (content.title, content.message)
    }
    
    private func setDataModel() {
        dataModel = TaskViewDataModel(secondaryButtonAction: {},
                                      taskSections: [createToDoSection(), createCompletedSection()])
    }
    
    private func createToDoSection() -> TaskSectionDataModel {
        let currentTasks = fetchedTasks.filter({ $0.taskStatus == .inProgress })
        let emptyTasks = currentTasks.count == 0
        return TaskSectionDataModel(title: "To do",
                                    buttonAction: { print("add task button") }, // send the view
                                    emptySectionTitle: emptyTasks ? "Create a Task" : nil,
                                    tasks: emptyTasks ? nil : currentTasks,
                                    taskTrailingOptions: [
                                        (buttonType: .edit,
                                         buttonAction: { [weak self] in
                                             self?.editTask()
                                         }),
                                        (buttonType: .delete,
                                         buttonAction: { [weak self] in
                                             self?.showDeletionConfirmation()
                                         })],
                                    taskLeadingOptions: [(buttonType: .completed,
                                                          buttonAction: { [weak self] in
            self?.completeTask()
        })])
    }
    
    
    
    private func createCompletedSection() -> TaskSectionDataModel {
        let completedTasks = fetchedTasks.filter({ $0.taskStatus == .completed })
        let emptyTasks = completedTasks.count == 0
        return TaskSectionDataModel(title: "Completed Tasks",
                                    emptySectionTitle: emptyTasks ? "No Completed Tasks" : nil,
                                    tasks: emptyTasks ? nil : completedTasks,
                                    taskTrailingOptions: [(buttonType: .delete,
                                                           buttonAction: { [weak self] in
            self?.deleteTask()
        })])
    }

    private func editTask() {
        shouldShowEditView.toggle()
    }
    
    private  func completeTask() {
        guard let selectedTask else { setErrorBanner(with: ("Task Not Completed", "We were unable to complete your task.")); return }
        if selectedTask.taskStatus != .completed {
            var updatedTask = selectedTask
            updatedTask.taskStatus = .completed
            taskRepository.updateTask(updatedValues: updatedTask,
                                      selectedTask: selectedTask)
        }
    }
    
    func deleteTask() {
        guard let selectedTask else { setErrorBanner(with: ("Task Not Deleted", "We were unable to delete your task.")); return }
        taskRepository.deleteTask(task: selectedTask)
    }
}
