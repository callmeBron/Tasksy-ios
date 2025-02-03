import SwiftUICore

enum TaskCategory: String, CaseIterable {
    case work = "work"
    case school = "school"
    case personal = "personal"
    
    var optionColor: Color {
        switch self {
        case .work:
            return .darkBlue
        case .school:
            return .darkPurple
        case .personal:
            return .darkPink
        }
    }
    
    var optionBGColor: Color {
        switch self {
        case .work:
            return .pastelBlue
        case .school:
            return .pastelPurple
        case .personal:
            return .pastelPink
        }
    }
}
