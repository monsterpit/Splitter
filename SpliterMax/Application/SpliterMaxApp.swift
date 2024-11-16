//
//  SpliterMaxApp.swift
//  SpliterMax
//
//  Created by Vikas Salian on 27/10/24.
//
//
import SharedCoreUI
import SwiftUI

@main
struct SpliterMaxApp: App {
//    var body: some Scene {
//        WindowGroup {
//            ContentView()
//        }
//    }

    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    @StateObject private var viewModel: RootViewModel = Application.shared.assembler.rootViewModel

    var body: some Scene {
        WindowGroup {
            ZStack {
                if let rootView = viewModel.rootView {
                    ZStack { // add another ZStack to provide transition animation when root view is changed
                        rootView
                            .id(rootView.id) // makes the view to update when rootView is changed
                            .ignoresSafeArea()
                    }
                    .animation(.default)
                }
                if viewModel.showActivityIndicator {
                    LoadingIndicator()
                }
            }
        }
    }
}
