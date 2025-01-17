import Foundation

struct Forecast: Decodable {
    let weather: Weather
    let temp: Double
    let timestampLocal: String?
    let ts: TimeInterval?

    enum CodingKeys: String, CodingKey {
        case weather
        case temp
        case timestampLocal = "timestamp_local"
        case ts
    }
}
