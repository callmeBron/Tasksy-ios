import SwiftUI

struct WeatherView: View {
    @StateObject var viewModel: WeatherViewModel
    
    init(viewModel: WeatherViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        if let error = viewModel.dataModel?.errorData {
            createErrorView(title: error.errorReason,
                            message: error.errorMessage)
            createWeatherView()
                .background {
                    Color.weatherCard
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .shadow(radius: 10)
                }
        } else {
            createWeatherView()
                .background {
                    Color.weatherCard
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
                .overlay {
                    viewModel.dataModel?.weatherData?.weatherCondition?.weatherConditionIcon
                        .resizable()
                        .frame(width: 50, height: 50)
                        .foregroundStyle(viewModel.dataModel?.weatherData?.weatherCondition?.temperatureColor ?? .black)
                        .padding()
                        .background {
                            Color.weatherCard
                                .clipShape(Circle())
                        }
                }
            if viewModel.shouldShowEmptyMessage {
                Text("Weather is updated every 15 minutes")
                    .font(.caption)
                    .multilineTextAlignment(.center)
                    .bold()
                    .foregroundStyle(.darkPurple)
            }
            
            if let data = viewModel.dataModel?.weatherData {
                if let tempC = data.tempC, let location = data.location {
                    VStack(spacing: 10) {
                        Text(tempC)
                            .font(.largeTitle)
                            .foregroundStyle(data.weatherCondition?.temperatureColor ?? .black)
                            .fontWeight(.semibold)
                        Text(location)
                            .bold()
                    }
                }
                
                if let humidity = data.humidity, let feelslikeC = data.feelslikeC {
                    HStack(spacing: 15) {
                        VStack(alignment: .center) {
                            Text(data.feelslikeC ?? "")
                            Text("feels like")
                                .font(.caption)
                                .foregroundStyle(.gray)
                        }
                        .padding(.horizontal, 5)
                        VStack(alignment: .center) {
                            Text(data.humidity ?? "")
                            Text("humidity")
                                .font(.caption)
                                .foregroundStyle(.gray)
                        }
                        .padding(.horizontal, 5)
                    }
                    .padding(.vertical)
                }
                
                if let sunrise = data.sunriseTime, let sunset = data.sunsetTime {
                    HStack {
                        VStack {
                            Image(systemName: "sunrise.fill")
                                .foregroundStyle(.yellow)
                            Text(data.sunriseTime ?? "")
                        }
                        Spacer()
                        VStack {
                            Image(systemName: "sunset.fill")
                                .foregroundStyle(.orange)
                            Text(data.sunsetTime ?? "")
                        }
                    }
                    .padding()
                }
            }
        }
    }
}
