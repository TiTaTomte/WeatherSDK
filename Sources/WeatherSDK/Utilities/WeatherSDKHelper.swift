import UIKit
import OSLog

class WeatherSDKHelper {
    private static let baseURLString = "https://api.weatherbit.io/v2.0/"

    @MainActor
    static func viewController(for city: String, apiKey: String?, delegate: WeatherSDKDelegate?, completion: @escaping (_ weatherViewController: WeatherViewController) -> Void) {
        guard let apiKey = apiKey, !city.isEmpty else {
            Logger().error("Please configure the SDK with a valid API key.")
            delegate?.onFinishedWithError()
            return
        }

        var forecastConfigurations = [CellConfiguration]()
        var tuple: (temp: String, weather: String, time: String)?

        let group = DispatchGroup()
        group.enter()
        fetchForecasts(city: city, apiKey: apiKey) { configurations in
            guard !configurations.isEmpty else {
                Logger().error("No forecast data available for \(city)")
                delegate?.onFinishedWithError()
                group.leave()
                return
            }

            forecastConfigurations = configurations
            group.leave()
        }

        group.enter()
        fetchCurrent(city: city, apiKey: apiKey) { (temp, weather, time) in
            guard let temp = temp, let weather = weather, let time = time else {
                Logger().error("No current weather available for \(city)")
                delegate?.onFinishedWithError()
                group.leave()
                return
            }

            tuple = (temp, weather, time)
            group.leave()
        }

        group.notify(queue: .main) {
            guard let tuple = tuple else {
                Logger().error("No current weather available for \(city)")
                delegate?.onFinishedWithError()
                return
            }

            let viewModel = WeatherViewModel(
                configurations: forecastConfigurations,
                currentCity: city,
                currentTemp: tuple.temp,
                currentWeather: tuple.weather,
                currentTime: tuple.time
            )

            let viewController = InternalWeatherViewController(viewModel: viewModel)
            viewController.delegate = delegate
            completion(viewController)
        }
    }

    @MainActor
    private static func fetchForecasts(city: String, apiKey: String, completion: @escaping (_ configurations: [CellConfiguration]) -> Void) {
        let urlString = "\(baseURLString)forecast/hourly?city=\(city)&hours=25&key=\(apiKey)"

        Task {
            do {
                let response = try await Network.fetchData(from: urlString, as: ForecastResponse.self)
                let data = response.data.dropLast() // There is no parameter for the start time so this is a workaround by fetching 25 hours and dropping the last

                let configurations = data.compactMap { item -> CellConfiguration? in
                    guard let timestamp = item.timestampLocal else { return nil }
                    return .init(timestamp: timestamp, temp: item.temp, weather: item.weather.description)
                }

                completion(configurations)
            } catch {
                Logger().error("error while fetching forecast: \(error.localizedDescription)")
                completion([])
            }
        }
    }

    @MainActor
    private static func fetchCurrent(city: String, apiKey: String, completion: @escaping (_ temp: String?, _ weather: String?, _ time: String?) -> Void) {
        let urlString = "\(baseURLString)current/?city=\(city)&key=\(apiKey)"

        Task {
            do {
                let response = try await Network.fetchData(from: urlString, as: ForecastResponse.self)
                guard let data = response.data.first, let timestamp = data.ts else {
                    Logger().error("No Data for current weather")
                    completion(nil, nil, nil)
                    return
                }

                let temp = "\(Int(data.temp))°C"
                let weather = data.weather.description
                let time = formattedTime(timestamp: timestamp)

                completion(temp, weather, time)
            } catch {
                Logger().error("error while fetching forecast: \(error.localizedDescription)")
                completion(nil, nil, nil)
            }
        }
    }

    private static func formattedTime(timestamp: TimeInterval) -> String {
        let date = Date(timeIntervalSince1970: timestamp)
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        formatter.dateStyle = .none
        formatter.timeZone = TimeZone.current

        return formatter.string(from: date)
    }
}
