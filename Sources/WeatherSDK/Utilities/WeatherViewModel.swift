import Foundation
import OSLog

class WeatherViewModel {
    var configurations: [CellConfiguration]
    var currentCity: String
    var currentTemp: String
    var currentWeather: String
    var currentTime: String

    init(configurations: [CellConfiguration], currentCity: String, currentTemp: String, currentWeather: String, currentTime: String) {
        self.configurations = configurations
        self.currentCity = currentCity
        self.currentTemp = currentTemp
        self.currentWeather = currentWeather
        self.currentTime = currentTime
    }
}
