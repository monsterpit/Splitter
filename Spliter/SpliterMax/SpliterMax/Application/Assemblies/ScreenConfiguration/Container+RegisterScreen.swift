//
// Copyright (c) 2025-present Vikas Salian. All Rights Reserved.
//

import Swinject
import UIKit

extension Container {
    @discardableResult
    func registerScreen<Config>(_ name: ScreenName,
                                factory: @escaping (Resolver, Config) -> UIViewController) -> ServiceEntry<UIViewController>
    {
        register(UIViewController.self, name: name.rawValue, factory: factory)
    }
}
