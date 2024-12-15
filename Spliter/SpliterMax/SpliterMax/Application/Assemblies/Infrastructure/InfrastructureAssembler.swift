//
// Copyright (c) 2025-present Vikas Salian. All Rights Reserved.
//

import Foundation
import Swinject
import SwinjectAutoregistration

enum InfrastructureAssembler {
    static var assemblies: [Assembly] {
        [
            LoggersAssembly(),
            NetworkAssembly(),
            RepositoriesAssembly(),
            StoragesAssembly(),
        ]
    }
}
