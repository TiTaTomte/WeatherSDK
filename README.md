# WeatherSDK Integration Guide

## Installation

### 1. **Install via Swift Package Manager**

1. Open your Xcode project.
2. Go to **File** → **Add Packages**.
3. Enter the repository URL of the WeatherSDK:
   ```
   https://github.com/TiTaTomte/WeatherSDK.git
   ```
4. Select the version you want to install and click **Add Package**.

### 2. **Install via Package.swift (For Libraries/Modules)**

Add the dependency to your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/TiTaTomte/WeatherSDK.git", from: "1.0.0")
]

targets: [
    .target(
        name: "YourApp",
        dependencies: ["WeatherSDK"]
    )
]
```

---

## Configuration

### 1. **Import the SDK**

```swift
import WeatherSDK
```

### 2. **Initialize the SDK**

```swift
WeatherSDK.shared.configure(apiKey: "YOUR_API_KEY")
```

- Replace `YOUR_API_KEY` with your valid API key.
- You can get an API key from [https://www.weatherbit.io](url).

---

## Fetch and Display Weather Forecast

### 1. **Retrieve Weather Data**

```swift
WeatherSDK.shared.getForecast(for: "Berlin") { weatherVC in
    navigationController?.pushViewController(weatherVC, animated: true)
}
```

### 2. **Handle Completion (Optional)**

Implement the `WeatherSDKDelegate` to handle success or failure:

```swift
class MyViewController: UIViewController, WeatherSDKDelegate {
    func onFinished(viewController: WeatherViewController) {
        print("User tapped on back button. WeatherViewController can be closed now.")
    }

    func onFinishedWithError() {
        print("Failed to load the weather forecast.")
    }
}

WeatherSDK.shared.delegate = self
```

# WeatherSDK Style Guide

This guide explains how to use the predefined **Style** system in the **WeatherSDK** for consistent design across your app.

---

## Sizes

Use the following size constants to maintain consistent spacing and layout:

```swift
Style.Size.xs   // 4pt  - Extra Small
Style.Size.s    // 8pt  - Small
Style.Size.m    // 16pt - Medium
Style.Size.l    // 24pt - Large
Style.Size.xl   // 32pt - Extra Large
Style.Size.xxl  // 48pt - Double Extra Large
Style.Size.xxxl // 56pt - Triple Extra Large
```

### **Example:**

```swift
let button = UIButton()
button.contentEdgeInsets = UIEdgeInsets(
    top: Style.Size.m,
    left: Style.Size.l,
    bottom: Style.Size.m,
    right: Style.Size.l
)
```

---

## Colors

Use the predefined color palette to ensure a unified color scheme:

```swift
Style.Colors.accent               // Primary accent color
Style.Colors.accentHighlighted    // Accent color for highlighted states
Style.Colors.textPrimary          // Primary text color
Style.Colors.textSecondary        // Secondary text color
Style.Colors.textPlaceholder      // Placeholder text color
Style.Colors.textBorder           // Border and separator color
Style.Colors.background           // Background color
Style.Colors.navigationBarBackground // Navigation bar background color
```

### **Example:**

```swift
let label = UILabel()
label.textColor = Style.Colors.textPrimary

view.backgroundColor = Style.Colors.background
```

---

## Fonts

Use the following fonts for consistent typography throughout the app:

```swift
Style.Fonts.h1         // Bold, 28pt - Large Headers
Style.Fonts.h2         // Bold, 20pt - Section Headers
Style.Fonts.title      // Bold, 16pt - Titles
Style.Fonts.textRegular // Medium, 16pt - Body Text
Style.Fonts.label      // Medium, 12pt - Labels and Captions
```

### **Example:**

```swift
let titleLabel = UILabel()
titleLabel.font = Style.Fonts.h1

titleLabel.text = "Today's Forecast"
titleLabel.textColor = Style.Colors.accent
```
