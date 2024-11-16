//
//  ViewControllerHolder.swift
//  Splitter
//
//  Created by Vikas Salian on 01/11/24.
//

import UIKit

public protocol ViewControllerHolderProtocol: AnyObject {
    var viewController: UIViewController? { get }
}

/// For cases when actual view controller is used instead of HostingController
extension UIViewController: ViewControllerHolderProtocol {
    public var viewController: UIViewController? {
        self
    }
}

public final class ViewControllerHolder: ViewControllerHolderProtocol {
    weak public var viewController: UIViewController?
    
    public init() {}
}
