//
//  ColorSet.swift
//  Splitter
//
//  Created by Vikas Salian on 02/11/24.
//

import SwiftUI

public protocol ColorSetConvertibleProtocol: ColorConvertibleProtocol {
    var convertible: ColorConvertible { get }
}

public extension ColorSetConvertibleProtocol {
    func toUIColor() -> UIColor {
        convertible.toUIColor()
    }

    func toColor() -> Color {
        convertible.toColor()
    }
}

public enum ColorSet {
    public enum Generic: ColorSetConvertibleProtocol {
        case black
        case grey(Grey)
        case red(Red)
        case green(Green)
        case background(Background)
        case white
        case orange(Orange)

        public var convertible: ColorConvertible {
            UserInterfaceConfiguration.colorProvider.color(set: self)
        }

        public enum Red: ColorSetConvertibleProtocol {
            case color0
            case color600

            public var convertible: ColorConvertible {
                UserInterfaceConfiguration.colorProvider.color(set: Generic.red(self))
            }
        }

        public enum Grey: ColorSetConvertibleProtocol {
            case color0
            case color100
            case color200
            case color300
            case color400
            case color500
            case color600
            case color700
            case color800
            case color900
            case color1000

            public var convertible: ColorConvertible {
                UserInterfaceConfiguration.colorProvider.color(set: Generic.grey(self))
            }
        }

        public enum Orange: ColorSetConvertibleProtocol {
            case color700

            public var convertible: ColorConvertible {
                UserInterfaceConfiguration.colorProvider.color(set: Generic.orange(self))
            }
        }

        public enum Green: ColorSetConvertibleProtocol {
            case color0
            case color100
            case color200
            case color300
            case color400
            case color500
            case color600
            case color700
            case color800
            case color900
            case color1000

            public var convertible: ColorConvertible {
                UserInterfaceConfiguration.colorProvider.color(set: Generic.green(self))
            }
        }

        public enum Background: ColorSetConvertibleProtocol {
            case coolState
            case lightGrey
            case white

            public var convertible: ColorConvertible {
                UserInterfaceConfiguration.colorProvider.color(set: Generic.background(self))
            }
        }
    }
}

public extension ColorSet {
    enum Accent: ColorSetConvertibleProtocol {
        case primary(Primary)
        case secondary
        case primaryIcon

        public var convertible: ColorConvertible {
            UserInterfaceConfiguration.colorProvider.color(set: self)
        }

        public enum Primary: ColorSetConvertibleProtocol {
            case primary
            case primaryLighter
            case primaryFocusDarker
            case primaryDarker

            public var convertible: ColorConvertible {
                UserInterfaceConfiguration.colorProvider.color(set: Accent.primary(self))
            }
        }
    }
}
