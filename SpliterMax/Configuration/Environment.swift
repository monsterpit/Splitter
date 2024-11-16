//
//  Environment.swift
//  Splitter
//
//  Created by Vikas Salian on 01/11/24.
//

import Foundation

enum Environment {
    case prod, uat, dev
    
    static var current: Environment {
//#if PROD
//        return .prod
//#endif
//#if DEV
//        return .dev
//#endif
//#if UAT
//        return .uat
//#endif
        return .dev
    }
    
    var name: String {
        switch self {
        case .prod:
            "prod"
        case .uat:
            "uat"
        case .dev:
            "dev"
        }
    }
    
    static var currentBrand: AppBrand {
        //TODO: check how is this flags managed
#if BRAND_PP
        return .Sliptter
#elseif BRAND_VISA
        return .SliptterPro
        #else
        return .Sliptter
#endif
    }
    
    static var appName: String {
        //TODO: Vikas check this values
        switch currentBrand {
        case .Sliptter:
            "priority_pass"
        case .SliptterPro:
            "visa_airport_experience"
        }
    }
    
    
}

enum AppBrand {
    case Sliptter
    case SliptterPro
    
    var capabilities: ProductCapability {
        switch self {
        case .Sliptter:
            SliptterProductConfiguration()
        case .SliptterPro:
            SplitterProProductConfiguration()
        }
    }
}
