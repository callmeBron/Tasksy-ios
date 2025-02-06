import SwiftUI

struct WeatherView: View {
    @StateObject var viewModel: WeatherViewModel
    
    init(viewModel: WeatherViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        if let title = viewModel.dataModel?.errorName, let message = viewModel.dataModel?.errorName {
            createErrorView(title: title, message: message)
            createWeatherView()
                .background {
                    Color.white
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .shadow(radius: 10)
                }
        } else {
            createWeatherView()
                .background {
                    Color.white
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .shadow(radius: 10)
                }
        }
    }
    
    @ViewBuilder
    private func createErrorView(title: String, message: String) -> some View {
        VStack(alignment: .center, spacing: 10) {
            Image(systemName: "exclamationmark.triangle")
                .resizable()
                .frame(width: 25, height: 25)
                .bold()
            Text(title)
                .bold()
            Text(message)
        }
        .foregroundStyle(.red)
    }
    
    @ViewBuilder
    private func createWeatherView() -> some View {

            VStack(alignment: .center, spacing: 20) {
                Image("weather background")
                    .resizable()
                    .frame(maxWidth: .infinity)
                    .aspectRatio(contentMode: .fit)
                    .roundedCorner(20, corners: [.topLeft, .topRight])
                
                VStack(spacing: 10) {
                    viewModel.dataModel?.weatherCondition?.weatherConditionIcon
                        .resizable()
                        .frame(width: 50, height: 50)
                        .foregroundStyle(viewModel.dataModel?.weatherCondition?.temperatureColor ?? .black)
                    Text(viewModel.dataModel?.tempC ?? "")
                        .font(.largeTitle)
                        .foregroundStyle(viewModel.dataModel?.weatherCondition?.temperatureColor ?? .black)
                        .fontWeight(.semibold)
                    Text(viewModel.dataModel?.location ?? "")
                        .bold()
                }
                
                HStack(spacing: 15) {
                    VStack(alignment: .center) {
                        Text(viewModel.dataModel?.feelslikeC ?? "")
                        Text("feels like")
                            .font(.caption)
                            .foregroundStyle(.gray)
                    }
                    .padding(.horizontal, 5)
                    VStack(alignment: .center) {
                        Text(viewModel.dataModel?.humidity ?? "")
                        Text("humidity")
                            .font(.caption)
                            .foregroundStyle(.gray)
                    }
                    .padding(.horizontal, 5)
                }
                .padding(.vertical)
                
                HStack {
                    VStack {
                        Image(systemName: "sunrise.fill")
                            .foregroundStyle(.yellow)
                        Text(viewModel.dataModel?.sunriseTime ?? "")
                    }
                    Spacer()
                    VStack {
                        Image(systemName: "sunset.fill")
                            .foregroundStyle(.orange)
                        Text(viewModel.dataModel?.sunsetTime ?? "")
                    }
                }.padding()
            }
    }
}
