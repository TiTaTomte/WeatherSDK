import UIKit

/// A namespace that provides consistent styling across the application, including sizes, colors, and fonts.
public struct Style {

    // MARK: - Size
    /// A collection of predefined spacing and sizing constants used throughout the app for consistent layout.
    public struct Size {

        /// Extra small size (4pt).
        public static let xs: CGFloat = 4

        /// Small size (8pt).
        public static let s: CGFloat = 8

        /// Medium size (16pt).
        public static let m: CGFloat = 16

        /// Large size (24pt).
        public static let l: CGFloat = 24

        /// Extra large size (32pt).
        public static let xl: CGFloat = 32

        /// Double extra large size (48pt).
        public static let xxl: CGFloat = 48

        /// Triple extra large size (56pt).
        public static let xxxl: CGFloat = 56
    }

    // MARK: - Colors
    /// A collection of color constants used throughout the app to ensure a consistent color scheme.
    public struct Colors {

        /// The primary accent color used for highlights and important UI elements.
        public static let accent = UIColor(named: "accent", in: Bundle.module, compatibleWith: nil) ?? .blue

        /// The highlighted state of the accent color, typically used for interactions.
        public static let accentHighlighted = UIColor(named: "accentHighlighted", in: Bundle.module, compatibleWith: nil) ?? .systemBlue

        /// The primary text color used for most readable content.
        public static let textPrimary = UIColor(named: "textPrimary", in: Bundle.module, compatibleWith: nil) ?? .black

        /// The secondary text color used for less prominent text.
        public static let textSecondary = UIColor(named: "textSecondary", in: Bundle.module, compatibleWith: nil) ?? .gray

        /// The placeholder text color used in input fields.
        public static let textPlaceholder = UIColor(named: "textPlaceholder", in: Bundle.module, compatibleWith: nil) ?? .lightText

        /// The color used for text field borders and separators.
        public static let textBorder = UIColor(named: "textBorder", in: Bundle.module, compatibleWith: nil) ?? .systemGray

        /// The general background color of the app.
        public static let background = UIColor(named: "background", in: Bundle.module, compatibleWith: nil) ?? .white

        /// The background color of the navigation bar.
        public static let navigationBarBackground = UIColor(named: "navigationBarBackground", in: Bundle.module, compatibleWith: nil) ?? .lightGray
    }

    // MARK: - Fonts
    /// A collection of predefined font styles used throughout the app for consistent typography.
    public struct Fonts {

        /// The bold font style for large headers (`28pt`).
        public static let h1: UIFont = .satoshiBold(ofSize: 28)

        /// The bold font style for medium headers (`20pt`).
        public static let h2: UIFont = .satoshiBold(ofSize: 20)

        /// The bold font style for titles (`16pt`).
        public static let title: UIFont = .satoshiBold(ofSize: 16)

        /// The medium font style for regular text (`16pt`).
        public static let textRegular: UIFont = .satoshiMedium(ofSize: 16)

        /// The medium font style for labels (`12pt`).
        public static let label: UIFont = .satoshiMedium(ofSize: 12)
    }
}
