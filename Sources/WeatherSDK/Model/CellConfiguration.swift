import Foundation

struct CellConfiguration {
    var text: NSAttributedString = NSAttributedString()

    init(timestamp: String, temp: Double, weather: String) {
        text = NSAttributedString(time(for: timestamp) + temperature(for: temp) + self.weather(weather))
    }

    private func time(for timestamp: String) -> AttributedString {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"

        guard let date = formatter.date(from: timestamp) else {
            return AttributedString("")
        }

        formatter.timeStyle = .short
        formatter.dateStyle = .none

        var attributed = AttributedString("\(formatter.string(from: date))  ")
        attributed.foregroundColor = Style.Colors.textPrimary
        attributed.font = Style.Fonts.textRegular

        return attributed
    }

    private func temperature(for temp: Double) -> AttributedString {
        var attributed = AttributedString("\(Int(temp))°C  ")
        attributed.foregroundColor = Style.Colors.textPrimary
        attributed.font = Style.Fonts.title

        return attributed
    }

    private func weather(_ weather: String) -> AttributedString {
        var attributed = AttributedString(weather)
        attributed.foregroundColor = Style.Colors.textPrimary
        attributed.font = Style.Fonts.textRegular

        return attributed
    }
}
