import SwiftUI
import Swinject

struct TaskView: View {
    @StateObject var viewModel: TaskViewModel
    @State var showPopUp: Bool = false
    
    
    init(viewModel: TaskViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        VStack {
            VStack(spacing: 20) {
                createViewHeader()
                if let notification = viewModel.dataModel?.notificationBanner {
                    NotificationBannerView(bannerTitle: notification.title,
                                           bannerMessage: notification.message)
                }
                if let sections = viewModel.dataModel?.taskSections {
                    ForEach(sections) { section in
                        VStack(spacing: 15) {
                            createSectionHeader(title: section.title,
                                                buttonAction: section.buttonAction)
                            .padding()
                            createSection(section: section)
                        }
                        .padding(.vertical)
                    }
                    
                    Spacer()
                }
            }
            .refreshable {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    viewModel.fetch()
                }
            }
            .popup(isPresented: $showPopUp) {
                let weatherView = DependencyContainer.shared.injectObject(AnyView.self,
                                                                          ObjectNames.TaskObjects.weatherView)
                weatherView
                    .padding()
            }
            .sheet(isPresented: $viewModel.showCreateTaskView) {
                let addTaskView = DependencyContainer.shared.injectObjectWArg(AnyView.self,
                                                                              ObjectNames.TaskObjects.taskFormView,
                                                                              nil)
                addTaskView
            }
            .sheet(isPresented: $viewModel.shouldShowEditView) {
                let updateTaskView = DependencyContainer.shared.injectObjectWArg(AnyView.self,
                                                                                 ObjectNames.TaskObjects.taskFormView,
                                                                                 viewModel.selectedTask)
                updateTaskView
            }
            .alert("Are you sure?", isPresented: $viewModel.showDeleteConfirmation) {
                Button("Cancel", role: .cancel) { }
                Button("Delete", role: .destructive) { viewModel.deleteTask() }
            } message: {
                Text("Tapping Delete will remove the task permanently.")
            }
        }
        .padding(.vertical)
    }
    
    @ViewBuilder
    private func createViewHeader() -> some View {
        HStack {
            Image("taskyLogo")
                .resizable()
                .frame(width: 150, height: 50)
            
            Spacer()
            
            Button {
                showPopUp.toggle()
            } label: {
                Image(systemName: "sun.max")
                    .resizable()
                    .frame(width: 20, height: 20)
                    .padding()
                    .bold()
                    .foregroundStyle(.orange)
                    .background {
                        Capsule()
                            .stroke(.gray.opacity(0.5), lineWidth: 0.5)
                    }
            }
            .padding(.horizontal)
        }
        .padding()
    }
    
    @ViewBuilder
    private func createSectionHeader(title: String, buttonAction: (() -> Void)? = nil) -> some View {
        HStack{
            Text(title)
                .font(.largeTitle)
                .bold()
            Spacer()
            if let buttonAction {
                Button {
                    buttonAction()
                    viewModel.showCreateView()
                } label: {
                    Image(systemName: "plus.circle.fill")
                        .resizable()
                        .foregroundStyle(Color.black, Color.white)
                        .frame(width: 25, height: 25)
                        .accessibilityIdentifier("taskAddButton")
                }
            }
        }
    }
    
    @ViewBuilder
    private func createSection(section: TaskSectionDataModel? = nil) -> some View {
        if let emptyStateString = section?.emptySectionTitle {
            Image(systemName: "tray.fill")
                .resizable()
                .frame(width: 25, height: 20)
            Text(emptyStateString)
                .font(.title3)
        }
        
        if var items = section?.tasks {
            List {
                ForEach(items) { task in
                    TaskCardView(taskTitle: task.taskTitle,
                                 taskDescription: task.taskDescription,
                                 taskCategory: task.taskCategory,
                                 taskStatus: task.taskStatus)
                    .swipeActions(edge: .leading, allowsFullSwipe: true) {
                        createButtons(task: task, buttons: section?.taskLeadingOptions)
                    }
                    .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                        createButtons(task: task, buttons: section?.taskTrailingOptions)
                    }
                }
                .onMove { IndexSet, destination in
                    items.move(fromOffsets: IndexSet, toOffset: destination)
                }
                .listRowSeparator(.hidden)
                .environment(\.defaultMinListRowHeight, 100)
            }
            .listStyle(.plain)
            .accessibilityIdentifier("task row")
        }
    }
    
    @ViewBuilder
    private func createButtons(task: TaskDataModel, buttons: [(buttonType: SwipeActionType, buttonAction: () -> Void)]?) -> some View {
        if let buttons = buttons {
            ForEach(buttons, id: \.buttonType.title) { button in
                Button {
                    viewModel.selectedTask = task
                    button.buttonAction()
                } label: {
                    HStack {
                        button.buttonType.icon
                        Text(button.buttonType.title)
                    }
                }.tint(button.buttonType.color)
            }
        }
    }
}

#Preview {
    TaskView(viewModel: TaskViewModel(taskRepository: RealmTaskDatabase()))
}
