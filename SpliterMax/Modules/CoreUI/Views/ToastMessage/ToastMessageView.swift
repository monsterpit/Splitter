//
//  ToastMessageView.swift
//  Splitter
//
//  Created by Vikas Salian on 02/11/24.
//

import SwiftUI

public struct ToastViewType: OptionSet {
    public let rawValue: UInt

    public init(rawValue: UInt) {
        self.rawValue = rawValue
    }

    /// Do not dismiss toast automatically
    public static let persistent: Self = .init(rawValue: 1 << 0)
    /// Smaller spacing between elements
    public static let compact: Self = .init(rawValue: 1 << 1)
    /// Show close button
    public static let closable: Self = .init(rawValue: 1 << 2)
    /// Show retry button
    public static let retriable: Self = .init(rawValue: 1 << 3)
}

public struct ToastMessage {
    let text: String
    let image: Image?

    public init(text: String, image: Image?) {
        self.text = text
        self.image = image
    }
}

struct ToastView: View {
    let message: ToastMessage
    let imageWidth: CGFloat
    let imageHeight: CGFloat
    let imageColor: Color
    let textColor: Color
    let closeButtonColor: Color
    let borderColor: Color
    let backgroundColor: Color
    var exitEventHandler: (() -> Void)?
    var retryEventHandler: (() -> Void)?
    var viewType: ToastViewType = [.compact]
    var hasDynamicWidth: Bool
    var fontStyle: FontSet.TextStyle
    var fontWeight: FontSet.Weight
    var body: some View {
        VStack {
            Spacer()
            let hSpacing = viewType.contains(.compact) ? DimensionConstants.hStackCompactSpacing : DimensionConstants.hStackRegularSpacing
            VStack {
                HStack(alignment: .firstTextBaseline, spacing: hSpacing) {
                    if let image = message.image {
                        image
                            .renderingMode(.template)
                            .resizable()
                            .frame(width: imageWidth, height: imageHeight)
                            .foregroundColor(imageColor)
                            .alignmentGuide(.firstTextBaseline) { dimensions in
                                dimensions[VerticalAlignment.center]
                            }
                    }

                    VStack(alignment: .leading, spacing: DimensionConstants.retryVStackSpacing) {
                        Text(message.text)
                            .appFont(style: fontStyle, weight: fontWeight)
                            .foregroundColor(textColor)
                            .alignmentGuide(.firstTextBaseline) { dimensions in
                                let remainingLine = (dimensions.height - dimensions[.lastTextBaseline])
                                let lineHeight = dimensions[.firstTextBaseline] + remainingLine
                                return lineHeight / 2
                            }
                        if viewType.contains(.retriable) {
                            Button("Retry") { retryEventHandler?() }
                                .foregroundColor(ColorSet.Accent.Primary.primary.toColor())
                                .appFont(style: fontStyle, weight: fontWeight)
                        }
                    }
                    if viewType.contains(.closable) {
                        if !hasDynamicWidth {
                            Spacer()
                        }

                        Button {
                            exitEventHandler?()
                        } label: {
                            Image(systemName: "x.circle.fill")
                                .renderingMode(.template)
                                .resizable()
                                .frame(width: DimensionConstants.crossImageSize, height: DimensionConstants.crossImageSize)
                                .foregroundColor(closeButtonColor)
                        }
                        .alignmentGuide(.firstTextBaseline) { dimensions in
                            dimensions[VerticalAlignment.center]
                        }
                    } else if !hasDynamicWidth {
                        Spacer()
                    }
                }
            }

            .padding(.vertical, DimensionConstants.verticalSpacing)
            .padding(.horizontal, DimensionConstants.horizontalSpacing)
            .background(backgroundColor)
            .overlay(
                RoundedRectangle(cornerRadius: DimensionConstants.cornerRadius)
                    .stroke(borderColor, lineWidth: DimensionConstants.borderWidth)
            )
            .clipShape(RoundedRectangle(cornerRadius: DimensionConstants.cornerRadius))
        }
        .padding(.bottom, DimensionConstants.bottomPadding)
        .padding(.horizontal, DimensionConstants.toastHorizontalPadding)
    }
}

extension ToastView {
    private enum DimensionConstants {
        static var bottomPadding: CGFloat { 16 }
        static var verticalSpacing: CGFloat { 16 }
        static var horizontalSpacing: CGFloat { 16 }
        static var cornerRadius: CGFloat { 8 }
        static var borderWidth: CGFloat { 2 }

        static var hStackCompactSpacing: CGFloat { 8 }
        static var hStackRegularSpacing: CGFloat { 12 }

        static var crossImageSize: CGFloat { 20 }
        static var retryVStackSpacing: CGFloat { 10 }
        static var toastHorizontalPadding: CGFloat { 8 }
    }
}

public extension View {
    func showNoInternetToast(isPresented: Binding<Bool>,
                             text: String? = nil,
                             image: Image = Image(systemName: "info.circle"),
                             imageWidth: CGFloat = 32,
                             imageHeight: CGFloat = 32,
                             imageColor: Color = ColorSet.Generic.Red.color600.toColor(),
                             textColor: Color = ColorSet.Generic.Grey.color800.toColor(),
                             borderColor: Color = ColorSet.Generic.Background.white.toColor(),
                             backgroundColor: Color = ColorSet.Generic.Background.white.toColor(),
                             closeButtonColor: Color = ColorSet.Generic.Grey.color1000.toColor(),
                             toastVisiblityDuration: Double = 1,
                             exitEventHandler: (() -> Void)? = nil,
                             retryEventHandler: (() -> Void)? = nil,
                             viewType: ToastViewType = [.persistent, .closable],
                             hasDynamicWidth: Bool = true,
                             fontStyle: FontSet.TextStyle = .bodyMd,
                             fontWeight: FontSet.Weight = .semibold) -> some View
    {
        showToast(isPresented: isPresented,
                  message: .init(text: text ?? "No Internet", image: image),
                  imageWidth: imageWidth,
                  imageHeight: imageHeight,
                  imageColor: imageColor,
                  textColor: textColor,
                  borderColor: borderColor,
                  backgroundColor: backgroundColor,
                  closeButtonColor: closeButtonColor,
                  toastVisiblityDuration: toastVisiblityDuration,
                  exitEventHandler: exitEventHandler,
                  retryEventHandler: retryEventHandler,
                  viewType: viewType,
                  hasDynamicWidth: hasDynamicWidth,
                  fontStyle: fontStyle,
                  fontWeight: fontWeight)
    }

    @ViewBuilder
    func showInfoToast(isPresented: Binding<Bool>,
                       message: ToastMessage?,
                       imageWidth: CGFloat = 16,
                       imageHeight: CGFloat = 16,
                       imageColor: Color = ColorSet.Generic.white.toColor(),
                       textColor: Color = ColorSet.Generic.white.toColor(),
                       borderColor: Color = .clear,
                       backgroundColor: Color = ColorSet.Generic.Grey.color900.toColor(),
                       closeButtonColor: Color = ColorSet.Generic.Grey.color400.toColor(),
                       toastVisiblityDuration: Double = 4,
                       exitEventHandler: (() -> Void)? = nil,
                       retryEventHandler: (() -> Void)? = nil,
                       viewType: ToastViewType = [.compact, .closable],
                       hasDynamicWidth: Bool = false,
                       fontStyle: FontSet.TextStyle = .bodySm,
                       fontWeight: FontSet.Weight = .medium) -> some View
    {
        if let message {
            showToast(isPresented: isPresented,
                      message: message,
                      imageWidth: imageWidth,
                      imageHeight: imageHeight,
                      imageColor: imageColor,
                      textColor: textColor,
                      borderColor: borderColor,
                      backgroundColor: backgroundColor,
                      closeButtonColor: closeButtonColor,
                      toastVisiblityDuration: toastVisiblityDuration,
                      exitEventHandler: exitEventHandler,
                      retryEventHandler: retryEventHandler,
                      viewType: viewType,
                      hasDynamicWidth: hasDynamicWidth,
                      fontStyle: fontStyle,
                      fontWeight: fontWeight)
        } else {
            modifier(EmptyModifier())
        }
    }
}

#Preview {
    VStack {
        Rectangle()
            .fill(.blue)
            .frame(maxWidth: .infinity)
            .showToast(isPresented: .constant(true),
                       message: .init(text: "Test Message", image: Image(systemName: "heart.circle")),
                       imageWidth: 20,
                       imageHeight: 20,
                       imageColor: Color(red: 44 / 255, green: 134 / 255, blue: 81 / 255),
                       textColor: Color(red: 44 / 255, green: 134 / 255, blue: 81 / 255),
                       borderColor: Color(red: 44 / 255, green: 134 / 255, blue: 81 / 255),
                       backgroundColor: Color(red: 237 / 255, green: 252 / 255, blue: 245 / 255),
                       toastVisiblityDuration: 4,
                       viewType: [.compact],
                       hasDynamicWidth: true)
    }
}
