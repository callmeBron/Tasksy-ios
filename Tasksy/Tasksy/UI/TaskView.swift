import SwiftUI

struct TaskView: View {
    @State var bool: Bool = false
    @StateObject var viewModel = TaskViewModel(taskRepository: MockTaskRepo())
    var body: some View {
        VStack(spacing: 20) {
            createViewHeader()
            ScrollView {
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
        }
        .scrollIndicators(.hidden)
        .sheet(isPresented: $bool) {
            ModifyTaskView(text: "",
                           description: "")
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
                    bool.toggle()
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
            ForEach(items) { task in
                TaskCardView(taskTitle: task.taskTitle,
                             taskDescription: task.taskDescription,
                             taskCategory: task.taskCategory,
                             taskStatus: task.taskStatus)
            }
        }
    }
}

#Preview {
    TaskView()
}
