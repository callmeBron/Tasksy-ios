import SwiftUI

public struct PopupView<PopupContent: View>: View {
    @Environment(\.dismiss) var dismiss
    @State private var scaleFactor: CGFloat = 0
    @State private var isAnimating: Bool = false
    var view: () -> PopupContent
    
    init(view: @escaping () -> PopupContent) {
        self.view = view
    }
    
    public var body: some View {
        ZStack {
            Color.gray.opacity(isAnimating ? 0.6 : 0)
                .scaleEffect(scaleFactor)
                .ignoresSafeArea()
            view()
                .scaleEffect(scaleFactor)
                .overlay {
                    VStack {
                        HStack(alignment: .top) {
                            Spacer()
                            Button {
                                withAnimation(.easeOut(duration: 0.2)) {
                                    isAnimating.toggle()
                                    scaleFactor = 0
                                }
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                    dismiss()
                                }
                            } label: {
                                Button {
                                    dismiss()
                                } label: {
                                    Image(systemName: "x.circle.fill")
                                        .resizable()
                                        .foregroundStyle(.white)
                                        .frame(width: 30,height: 30)
                                }
                            }
                        }
                        .padding()
                        Spacer()
                    }
                    .padding()
                    .scaleEffect(scaleFactor)
                }
        }
        .onAppear {
            withAnimation(.bouncy(duration: 0.5)) {
                isAnimating.toggle()
                scaleFactor = 1
            }
        }
    }
}
