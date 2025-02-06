import SwiftUI

extension View {
    func roundedCorner(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
    
    public func popup<view: View>(isPresented: Binding<Bool>,
                                  @ViewBuilder view: @escaping () -> view) -> some View {
        fullScreenCover(isPresented: isPresented) {
            PopupView {
                view()
            }
        }
        .ignoresSafeArea()
    }
}
