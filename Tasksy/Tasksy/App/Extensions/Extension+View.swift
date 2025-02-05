import SwiftUI

extension View {
    public func popup<PopupContent: View>(
        isPresented: Binding<Bool>,
        view: @escaping () -> PopupContent) -> some View {
            self.modifier(
                Popup(
                    isPresented: isPresented,
                    view: view)
            )
        }
}

public struct Popup<PopupContent>: ViewModifier where PopupContent: View {
    /// Controls if the sheet should be presented or not
    @Binding var isPresented: Bool
    
    /// The content to present
    var view: () -> PopupContent
    
    init(isPresented: Binding<Bool>,
         view: @escaping () -> PopupContent) {
        self._isPresented = isPresented
        self.view = view
    }
    
    public func body(content: Content) -> some View {
        content
    }
}
