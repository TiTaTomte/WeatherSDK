import UIKit

/// A protocol that represents a view controller for displaying weather forecasts.
///
/// This protocol abstracts the internal weather view controller used by the SDK, allowing the `WeatherSDK`
/// to return a type-safe interface without exposing internal implementation details.
///
/// Use instances conforming to `WeatherViewController` to present weather forecast information in your app.
///
/// - Note: This protocol should not be implemented directly. Use the provided methods in `WeatherSDK` to retrieve
/// a fully configured weather view controller.
public protocol WeatherViewController: UIViewController {}
