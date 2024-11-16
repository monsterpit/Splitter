// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
public enum StringConstants {
  /// Cancel
  public static let cancel = StringConstants.tr("Localizable", "Cancel", fallback: "Cancel")
  /// Ok
  public static let ok = StringConstants.tr("Localizable", "Ok", fallback: "Ok")
  public enum JailBreak {
    /// Jail Broken device detected
    public static let alertDesc = StringConstants.tr("Localizable", "JailBreak.AlertDesc", fallback: "Jail Broken device detected")
    /// Security Alert
    public static let alertTitle = StringConstants.tr("Localizable", "JailBreak.AlertTitle", fallback: "Security Alert")
    /// Localizable.strings
    ///   SpliterMax
    /// 
    ///   Created by Vikas Salian on 02/11/24.
    public static let message = StringConstants.tr("Localizable", "JailBreak.Message", fallback: "This device is jailbroken, which can pose a security risk. Please use a secure device.")
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension StringConstants {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg..., fallback value: String) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: value, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
