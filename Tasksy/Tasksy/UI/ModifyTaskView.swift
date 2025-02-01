import SwiftUI

struct ModifyTaskView: View {
    @State var text: String
    var body: some View {
        VStack {
            Text("Create Task")
                .font(.largeTitle)
                .bold()
            
            VStack {
                HStack {
                    Text("Title")
                        .font(.caption)
                    Spacer()
                }
                TextField("title", text: $text)
                
                Rectangle()
                    .frame(height: 1.0, alignment: .bottom)
                    .foregroundColor(Color.gray)
                
            }
            .padding()
            
            
            VStack {
                HStack {
                    Text("Description")
                        .font(.caption)
                    Spacer()
                }
                TextField("title", text: $text)
                
                Rectangle()
                    .frame(height: 1.0, alignment: .bottom)
                    .foregroundColor(Color.gray)
                
            }
            .padding()
            VStack {
                HStack {
                    Text("Category")
                        .font(.caption)
                    Spacer()
                }
            }
            .padding()
        }
        .frame(maxHeight: .infinity)
        .safeAreaInset(edge: .bottom) {
            Button {
                // action
            } label: {
                Text("Create")
                    .bold()
                    .foregroundStyle(.white)
                    .padding()
                    .background {
                        RoundedRectangle(cornerRadius: 8)
                            .foregroundStyle(.purple)
                    }
            }
        }
    }
}

#Preview {
    ModifyTaskView(text: "")
}
