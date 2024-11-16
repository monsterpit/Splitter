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
import Utils

final class AppAssembler {
    private(set) var rootViewModel: RootViewModel
    private(set) var coordinator: RootCoordinator
    private(set) var appSessionService: ApplicationSessionServiceProtocol
    private(set) var userService: UserService
    let logger = LoggerAssembly.logger

    init() {
        let loggerProvider = LogAnalyticsProvider(logger: logger)
        let analyticsService = AnalyticsService(providers: [loggerProvider], environment: .init(environment: Environment.current))
        let screenViewTracker = ScreenViewTracker(analytics: analyticsService)
        let networkMonitor = NetworkMonitorRepository()

        let appState = AppState(viewLoadTracker: ViewLoadTracker(delegate: screenViewTracker), networkMonitor: networkMonitor)

        let userStorage = UserKeychainStorage(keychainStorage: StoragesAssembly.keychain, userDefaultsStorage: StoragesAssembly.userDefault)

        let userRepository = UserRepository(logger: logger, storage: userStorage)

        userService = UserService(repository: userRepository)

        coordinator = RootCoordinator(appState: appState,
                                      logger: logger)

        rootViewModel = RootViewModel(coordinator: coordinator)

        let applicationSessionRepository = ApplicationSessionRepository(storage: ApplicationSessionStorage(keyValueStorage: StoragesAssembly.userDefault), authRepository: AuthRepository(), appName: Environment.appName)

        appSessionService = ApplicationSessionService(repository: applicationSessionRepository)
    }
}

// private extension AppAssembler {
//    static var assemblies: [Assembly] {
//        [
//            InfrastructureAssembler.assemblies,
//            [ServicesAssembly()],
//            [RootScreenAssembly(), SignupFlowAssembly()],
//            MainScreensAssembly.assemblies
//        ].flatMap { $0 }
//    }
// }
