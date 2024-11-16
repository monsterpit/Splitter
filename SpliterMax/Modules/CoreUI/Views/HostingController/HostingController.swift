//
//  HostingController.swift
//  Splitter
//
//  Created by Vikas Salian on 02/11/24.
//

import SwiftUI

public protocol ViewControllableProtocol: View {
    var holder: ViewControllerHolder { get set }
    var title: String { get }
    var shouldDismissKeyboardOnGlobalTap: Bool { get }
    
    func loadView()
    func viewOnAppear(viewController: UIViewController)
}

public extension ViewControllableProtocol {
    var title: String { "" }
    
    var viewController: UIViewController {
        if let viewController = holder.viewController {
            return viewController
        }
        let viewController = HostingController(rootView: self)
        viewController.title = title
        holder.viewController = viewController
        return viewController
    }
    
    var shouldDismissKeyboardOnGlobalTap: Bool { true }
  
    func loadView() {}
    func viewOnAppear(viewController: UIViewController) {}
}

final class HostingController<ContentView>: UIHostingController<ContentView> where ContentView: ViewControllableProtocol {
    override func loadView() {
        super.loadView()
        rootView.loadView()
        if rootView.shouldDismissKeyboardOnGlobalTap {
            hideKeyboardWhenTappedAround()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        rootView.viewOnAppear(viewController: self)
    }
    
    private func hideKeyboardWhenTappedAround() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }

    @objc private func hideKeyboard(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
}
