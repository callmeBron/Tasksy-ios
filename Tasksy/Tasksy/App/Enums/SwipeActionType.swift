import SwiftUICore

enum SwipeActionType {
    case edit
    case delete
    case completed
    
    var title: String {
        switch self {
        case .edit:
            "Edit Task"
        case .delete:
            "Delete Task"
        case .completed:
            "Mark as Completed"
        }
    }
    
    var color: Color {
        switch self {
        case .edit:
            .orange
        case .delete:
            .red
        case .completed:
            .green
        }
    }
    
    var icon: Image {
        switch self {
        case .edit:
            Image(systemName: "pencil")
        case .delete:
            Image(systemName: "trash.fill")
        case .completed:
            Image(systemName: "checkmark.circle.fill")
        }
    }
}
