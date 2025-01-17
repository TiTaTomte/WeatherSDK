import UIKit
import OSLog

extension UIFont {
    enum FontError: Swift.Error {
        case failedToRegisterFont
    }

    private enum SatoshiFontName {
        static let bold   = "Satoshi-Bold"
        static let medium = "Satoshi-Medium"
    }

    static func satoshiBold(ofSize size: CGFloat) -> UIFont {
        do {
            try registerFont(named: SatoshiFontName.bold)
            return UIFont(name: SatoshiFontName.bold, size: size) ?? UIFont.boldSystemFont(ofSize: size)
        } catch {
            return UIFont.boldSystemFont(ofSize: size)
        }
    }

    static func satoshiMedium(ofSize size: CGFloat) -> UIFont {
        do {
            try registerFont(named: SatoshiFontName.medium)
            return UIFont(name: SatoshiFontName.medium, size: size) ?? UIFont.boldSystemFont(ofSize: size)
        } catch {
            return UIFont.boldSystemFont(ofSize: size)
        }
    }

    private static func registerFont(named name: String) throws {
        guard let asset = NSDataAsset(name: "Fonts/\(name)", bundle: Bundle.module),
              let provider = CGDataProvider(data: asset.data as NSData),
              let font = CGFont(provider),
              CTFontManagerRegisterGraphicsFont(font, nil)
        else {
            throw FontError.failedToRegisterFont
        }
    }
}
