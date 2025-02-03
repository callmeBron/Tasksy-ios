import SwiftUI

struct NotificationBannerView: View {
    let bannerTitle: String
    let bannerMessage: String
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 10) {
                HStack(alignment: .top) {
                    Image(systemName: "exclamationmark.triangle")
                        .resizable()
                        .frame(width: 25, height: 25)
                        .bold()
                    Spacer()
                }
                Text(bannerTitle)
                    .bold()
                Text(bannerMessage)
            }
            .foregroundStyle(.red)
            .fixedSize(horizontal: false, vertical: true)
            .multilineTextAlignment(.leading)
            
            Spacer()
        }
        .padding()
        .background {
            RoundedRectangle(cornerRadius: 10)
                .foregroundStyle(.red.opacity(0.5))
        }
        .padding(.horizontal)
    }
}

#Preview {
    NotificationBannerView(bannerTitle: "", bannerMessage: "")
}
