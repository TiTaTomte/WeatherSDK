import UIKit

/// A delegate protocol that notifies about the tap on the back button of the `WeatherViewController` or failure of weather forecast retrieval.
///
/// Implement this protocol to handle events when the weather forecast is either successfully presented
/// or fails due to an error.
public protocol WeatherSDKDelegate: AnyObject {

    /// Notifies the delegate that the `WeatherViewController`can be dismissed after the user tapped on the back button.
    ///
    /// - Parameter viewController: The `WeatherViewController` instance displaying the forecast.
    ///
    /// Use this method to perform any actions after the weather view is presented,
    /// such as dismissing the `WeatherViewController`.
    func onFinished(viewController: WeatherViewController)

    /// Notifies the delegate that an error occurred while fetching or presenting the forecast.
    ///
    /// This method is called when the weather data cannot be retrieved or the view cannot be displayed.
    /// Use this to handle errors gracefully, such as showing an alert or retrying the operation.
    func onFinishedWithError()
}
