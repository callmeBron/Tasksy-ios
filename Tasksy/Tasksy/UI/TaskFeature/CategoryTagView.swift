import SwiftUI

struct CategoryTagView: View {
    let category: TaskCategory
    
    var body: some View {
        switch category {
        case .work:
            tagView(title: category.rawValue,
                    textColor: category.optionColor,
                    bgColor: category.optionBGColor)
        case .school:
            tagView(title: category.rawValue,
                    textColor: category.optionColor,
                    bgColor: category.optionBGColor)
        case .personal:
            tagView(title: category.rawValue,
                    textColor: category.optionColor,
                    bgColor: category.optionBGColor)
        }
    }
    
    @ViewBuilder
    private func tagView(title:String, textColor: Color, bgColor: Color) -> some View {
        VStack {
            Text(title)
                .foregroundStyle(textColor)
                .bold()
        }
        .padding(8)
        .background {
            Capsule()
                .foregroundStyle(bgColor)
        }
    }
}

#Preview {
    CategoryTagView(category: .personal)
}
