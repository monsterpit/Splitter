//
//  MainViewModel.swift
//  Splitter
//
//  Created by Vikas Salian on 02/11/24.
//

import Foundation

protocol MainViewModelProtocol {}

final class MainViewModel: MainViewModelProtocol {
    private let coordinator: MainTabBarCoordinatorProtocol
    
    init(coordinator: MainTabBarCoordinatorProtocol) {
        self.coordinator = coordinator
    }
}
