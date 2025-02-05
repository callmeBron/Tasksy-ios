import SwiftUI

struct WeatherView: View {
    @Environment(\.dismiss) var dismiss
    var body: some View {
        VStack {
            VStack(alignment: .center, spacing: 20) {
                HStack(alignment: .top) {
                    Spacer()
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "x.circle.fill")
                            .resizable()
                            .foregroundStyle(.gray.opacity(0.6))
                            .frame(width: 30,height: 30)
                    }
                    
                }
                .padding()
                
                Image(systemName: "circle.fill")
                    .resizable()
                    .foregroundStyle(.gray)
                    .frame(width: 120, height: 120)
                VStack {
                    Text("36°C")
                        .font(.largeTitle)
                        .foregroundStyle(.gray)
                        .fontWeight(.semibold)
                    Text("Krugersdorp, South Africa")
                        .bold()
                }
                
                HStack() {
                    VStack {
                        Image(systemName: "sunrise.fill")
                        Text("6:00 am")
                    }
                    Spacer()
                    VStack {
                        Image(systemName: "sunset.fill")
                        Text("7:00 pm")
                    }
                }.padding()
            }
        }
        .padding()
        .background() {
            RoundedRectangle(cornerRadius: 8).stroke(.gray.opacity(0.5), lineWidth: 0.5)
                .shadow(radius: 2)
        }
    }
}

#Preview {
    WeatherView()
}
