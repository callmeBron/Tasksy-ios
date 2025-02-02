import SwiftUI
import Swinject

struct TaskView: View {
    @State var showCreateTask: Bool = false
    @State var showDeleteConfirmation: Bool = false
    
    @StateObject var viewModel: TaskViewModel
    private let addTaskView = TaskContainer.shared.injectObject(AnyView.self, "TaskModifierView")
    
    init(viewModel: TaskViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
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
                            createSection(emptyStateString: section.emptySectionTitle,
                                          items: section.tasks)
                        }
                        .padding(.vertical)
                    }
                    
                    Spacer()
                }
            }
        .refreshable {
            viewModel.fetch()
        }
        .sheet(isPresented: $showCreateTask) {
            addTaskView
        }
        .alert("Are you sure?", isPresented: $showDeleteConfirmation) {
            Button("Cancel", role: .cancel) { }
            Button("Delete", role: .destructive) { viewModel.deleteTask() }
        } message: {
            Text("Tapping Delete will remove the task permanently.")
        }
    }
        
    @ViewBuilder
    private func createViewHeader() -> some View {
        HStack {
            Image("taskyLogo")
                .resizable()
                .frame(width: 150, height: 50)
            
            Spacer()
            
            Button {
                viewModel.dataModel?.secondaryButtonAction()
            } label: {
                Image(systemName: "sun.max")
                    .resizable()
                    .frame(width: 20, height: 20)
                    .padding()
                    .bold()
                    .foregroundStyle(.orange)
                    .background {
                        Capsule()
                            .frame(width: 100)
                            .foregroundStyle(.white)
                            .shadow(radius: 2)
                    }
            }.padding(.horizontal)
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
                    showCreateTask.toggle()
                } label: {
                    Image(systemName: "plus.circle.fill")
                        .resizable()
                        .foregroundStyle(Color.black, Color.white)
                        .frame(width: 25, height: 25)
                }
            }
        }
    }
    
    @ViewBuilder
    private func createSection(emptyStateString: String? = nil, items: [TaskDataModel]? = nil) -> some View {
        if let emptyStateString {
            Image(systemName: "tray.fill")
                .resizable()
                .frame(width: 25, height: 20)
            Text(emptyStateString)
                .font(.title3)
        }
        
        if let items {
            List {
                ForEach(items) { task in
                    TaskCardView(taskTitle: task.taskTitle,
                                 taskDescription: task.taskDescription,
                                 taskCategory: task.taskCategory,
                                 taskStatus: task.taskStatus)
                    .swipeActions {
                        Button {
                            //action
                        } label: {
                            HStack {
                                Image(systemName: "pencil")
                                Text("Edit Task")
                            }
                        }.tint(.orange)
                        
                        Button(role: .destructive) {
                            viewModel.selectedTask = task
                            showDeleteConfirmation.toggle()
                        } label: {
                            HStack {
                                Image(systemName: "trash.fill")
                                Text("Delete Task")
                            }
                        }.tint(.red)
                    }
                    
                }
            }
            .listStyle(.plain)
        }
    }
}

#Preview {
    TaskView(viewModel: TaskViewModel(taskRepository: ConcreteTaskRepository()))
}
