import UIKit
import OSLog

/// A singleton class to configure and manage weather forecast retrieval.
final public class WeatherSDK {
    /// Shared singleton instance of the WeatherSDK.
    @MainActor public static let shared = WeatherSDK()

    /// The delegate that receives SDK callbacks.
    public var delegate: WeatherSDKDelegate?

    private var apiKey: String?

    /// Configures the SDK with an optional API key.
    /// - Parameter apiKey: Optional API key for accessing the weather service.
    public func configure(apiKey: String? = nil) {
        self.apiKey = apiKey
    }

    /// Fetches the weather forecast for a specified city.
    /// - Parameters:
    ///   - city: The name of the city for which the forecast is needed.
    ///   - completion: A closure returning the `WeatherViewController` displaying the forecast.
    @MainActor
    public func getForecast(for city: String, completion: @escaping (_ weatherViewController: WeatherViewController) -> Void) {
        WeatherSDKHelper.viewController(for: city, apiKey: apiKey, delegate: delegate, completion: completion)
    }
}
