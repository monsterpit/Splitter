//
//  AppAssembler.swift
//  Splitter
//
//  Created by Vikas Salian on 01/11/24.
//
import Domain
import Foundation
import Infrastructure
import Services
import Swinject
import SwinjectAutoregistration
import Utils

final class AppAssembler {
    private(set) lazy var appSessionService: ApplicationSessionServiceProtocol = assembler.resolver~>
    private(set) lazy var rootViewModel: RootViewModel = assembler.resolver~>
    private(set) lazy var coordinator: RootCoordinator = assembler.resolver~>

    let assembler: Assembler = .init(assemblies)
}

private extension AppAssembler {
    static var assemblies: [Assembly] {
        [
            InfrastructureAssembler.assemblies,
            [ServicesAssembly()],
            [RootScreenAssembly()],
            MainScreensAssembly.assemblies,
        ].flatMap { $0 }
    }
}
