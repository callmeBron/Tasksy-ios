import SwiftUI

struct TaskCardView: View {
    let taskTitle: String
    let taskDescription: String
    let taskCategory: TaskCategory
    let taskStatus: TaskStatus
    
    var body: some View {
        VStack {
            taskContent()
            HStack {
                Spacer()
                CategoryTagView(category: taskCategory)
            }
        }
        .padding()
        .background() {
            RoundedRectangle(cornerRadius: 8).stroke(.gray.opacity(0.5), lineWidth: 0.5)
                .shadow(radius: 2)
        }
        .padding(.horizontal)
    }
    @ViewBuilder
    private func taskContent() -> some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading) {
                Text(taskTitle)
                    .font(.title2)
                    .bold()
                
                Text(taskDescription)
                    .font(.subheadline)
                    .foregroundStyle(Color.gray)
                
            }
            .fixedSize(horizontal: false, vertical: true)
            .multilineTextAlignment(.leading)
            Spacer()
            cardStatus()
        }
    }
    @ViewBuilder
    private func cardStatus() -> some View {
        switch taskStatus {
        case .inProgress:
            Image(systemName: "circle")
                .foregroundStyle(.gray)
        case .completed:
            Image(systemName: "checkmark.circle.fill")
                .foregroundStyle(.green)
        }
    }
}

#Preview {
    VStack(spacing: 20) {
        TaskCardView(taskTitle: "Study Sorting Algorithms",
                     taskDescription: "on  Saturday night live",
                     taskCategory: .work,
                     taskStatus: .inProgress)
        
        TaskCardView(taskTitle: "Study Sorting Algorithms",
                     taskDescription: "on  Saturday night live",
                     taskCategory: .personal,
                     taskStatus: .completed)
        
        TaskCardView(taskTitle: "Study Sorting Algorithms",
                     taskDescription: "on  Saturday night live",
                     taskCategory: .school, taskStatus: .completed)
    }
}
