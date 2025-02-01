import SwiftUI

struct CategoryTagView: View {
    let category: TaskCategory
    
    var body: some View {
        switch category {
        case .work:
            tagView(title: category.rawValue,
                    textColor: Color.darkBlue,
                    bgColor: Color.pastelBlue)
        case .school:
            tagView(title: category.rawValue,
                    textColor: Color.darkPurple,
                    bgColor: Color.pastelPurple)
        case .personal:
            tagView(title: category.rawValue,
                    textColor: Color.darkPink,
                    bgColor: Color.pastelPink)
        }
    }
    @ViewBuilder
    private func tagView(title:String, textColor: Color, bgColor: Color) -> some View {
        VStack {
            Text(title)
                .foregroundStyle(textColor)
                .bold()
        }
        .padding()
        .background {
            Capsule()
                .foregroundStyle(bgColor)
        }
    }
}

#Preview {
    CategoryTagView(category: .personal)
}
