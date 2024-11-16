//
//  RootViewRepresentable.swift
//  Splitter
//
//  Created by Vikas Salian on 01/11/24.
//

//TODO: Check Vikas

import SwiftUI

struct RootViewRepresentable: UIViewControllerRepresentable {
    let id: UUID = .init()
    
    private let viewController: UIViewController
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
    func makeUIViewController(context: Context) -> UIViewController {
        viewController
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}

