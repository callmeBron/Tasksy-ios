import SwiftUI

struct TaskFormView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel: TaskFormViewModel
    
    init(viewModel: TaskFormViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        VStack {
            VStack {
                HStack {
                    Text("Title")
                        .font(.caption)
                        .bold()
                    Spacer()
                }
                TextField("Task Title", text: $viewModel.title)
                    .frame(maxWidth: .infinity)
                    .accessibilityIdentifier("taskTitleTextField")
                
                Rectangle()
                    .frame(height: 1.0, alignment: .bottom)
                    .foregroundColor(Color.gray)
                
            }
            .padding()
            
            VStack {
                HStack {
                    Text("Description")
                        .font(.caption)
                        .bold()
                    Spacer()
                }
                
                TextField("Task Description", text: $viewModel.description)
                    .frame(maxWidth: .infinity)
                    .accessibilityIdentifier("taskDescriptionTextField")
                Rectangle()
                    .frame(height: 1.0, alignment: .bottom)
                    .foregroundColor(Color.gray)
                
            }
            .padding()
            VStack {
                HStack {
                    Text("Category")
                        .font(.caption)
                        .bold()
                    Spacer()
                }
                
                Picker("Category", selection: $viewModel.category) {
                    ForEach(viewModel.taskOptions, id: \.self) { category in
                        Text(category.rawValue)
                            .bold()
                            .foregroundStyle(category.optionColor)
                    }
                }.pickerStyle(.wheel)
            }
            .padding()
            Spacer()
        }
        .frame(maxHeight: .infinity)
        .safeAreaInset(edge: .top, content: {
            VStack {
                Text(viewModel.viewTitle)
                    .font(.largeTitle)
                    .bold()
                Rectangle()
                    .frame(height: 1.0, alignment: .bottom)
                    .foregroundColor(Color.gray)
            }
            .padding()
        })
        .safeAreaInset(edge: .bottom) {
            Button {
                viewModel.buttonAction?()
                dismiss()
            } label: {
                Text(viewModel.buttonTitle)
                    .bold()
                    .foregroundStyle(.white)
                    .padding()
                    .background {
                        RoundedRectangle(cornerRadius: 8)
                            .foregroundStyle(.purple)
                    }
            }
            .ignoresSafeArea(.keyboard)
        }
    }
}

#Preview {
    TaskFormView(viewModel: TaskFormViewModel(taskRepository: RealmTaskDatabase()))
}
