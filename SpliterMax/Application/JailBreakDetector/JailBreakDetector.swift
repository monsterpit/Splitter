//
//  JailBreakDetector.swift
//  Splitter
//
//  Created by Vikas Salian on 01/11/24.
//

import Infrastructure
import UIKit

enum JailBreakDetector {
    static func isJailBroken(logger: LoggerProtocol?) -> Bool {
        let isCydiaInstalled = hasCydiaInstalled()
        let fileCheck = isPathsExist()
        let directories = isDirectoriesWriteable(logger: logger)
        let suspiciousApps = isContainsSuspiciousApps()

        return isCydiaInstalled ||
            fileCheck ||
            directories ||
            suspiciousApps ? true : false
    }

    // check if cydia is installed (using URI Scheme)
    private static func hasCydiaInstalled() -> Bool {
        UIApplication.shared.canOpenURL(URL(string: "cydia://")!)
    }

    // suspicious system and app paths to check
    private static var suspicousAppandSystemPaths: [String] {
        [
            "/usr/sbin/frida-server",
            "FridaGadget",
            "libcycript",
            "cynject",
            "/etc/apt/sources.list.d/electra.list",
            "/etc/apt/sources.list.d/sileo.sources",
            "/.bootstrapped_electra",
            "/usr/lib/libjailbreak.dylib",
            "/jb/lzma",
            "/.cydia_no_stash",
            "/.installed_unc0ver",
            "/jb/offsets.plist",
            "/usr/share/jailbreak/injectme.plist",
            "/etc/apt/undecimus/undecimus.list",
            "/var/lib/dpkg/info/mobilesubstrate.md5sums",
            "/Library/MobileSubstrate/MobileSubstrate.dylib",
            "/jb/jailbreakd.plist",
            "/jb/amfid_payload.dylib",
            "/jb/libjailbreak.dylib",
            "/usr/libexec/cydia/firmware.sh",
            "/var/lib/cydia",
            "/etc/apt",
            "/private/var/lib/apt",
            "/private/var/Users/",
            "/var/log/apt",
            "/Applications/Cydia.app",
            "/private/var/stash",
            "/private/var/lib/apt/",
            "/private/var/lib/cydia",
            "/private/var/cache/apt/",
            "/private/var/log/syslog",
            "/private/var/tmp/cydia.log",
            "/Applications/Icy.app",
            "/Applications/MxTube.app",
            "/Applications/RockApp.app",
            "/Applications/blackra1n.app",
            "/Applications/SBSettings.app",
            "/Applications/FakeCarrier.app",
            "/Applications/WinterBoard.app",
            "/Applications/IntelliScreen.app",
            "/private/var/mobile/Library/SBSettings/Themes",
            "/Library/MobileSubstrate/CydiaSubstrate.dylib",
            "/System/Library/LaunchDaemons/com.ikey.bbot.plist",
            "/Library/MobileSubstrate/DynamicLibraries/Veency.plist",
            "/Library/MobileSubstrate/DynamicLibraries/LiveClock.plist",
            "/System/Library/LaunchDaemons/com.saurik.Cydia.Startup.plist",
        ]
    }

    private static func isPathsExist() -> Bool {
        for path in suspicousAppandSystemPaths where FileManager.default.fileExists(atPath: path) {
            return true
        }
        return false
    }

    private static var directories: [String] {
        [
            "/",
            "/root/",
            "/private/",
            "/jb/",
        ]
    }

    private static func isDirectoriesWriteable(logger _: LoggerProtocol?) -> Bool {
        // Checks if the restricted directories are writeable.
        for path in directories {
            do {
                let filePath = path + UUID().uuidString
                try "i escaped the Jail".write(toFile: filePath, atomically: true, encoding: .utf8)
                try FileManager.default.removeItem(atPath: filePath)
                return true
            } catch {}
        }
        return false
    }

    // suspicious apps path to check
    private static var suspiciousAppsPathToCheck: [String] {
        ["/Applications/Cydia.app",
         "/Applications/blackra1n.app",
         "/Applications/FakeCarrier.app",
         "/Applications/Icy.app",
         "/Applications/IntelliScreen.app",
         "/Applications/MxTube.app",
         "/Applications/RockApp.app",
         "/Applications/SBSettings.app",
         "/Applications/WinterBoard.app"]
    }

    // Check if suspicious apps (Cydia, FakeCarrier, Icy etc.) is installed
    private static func isContainsSuspiciousApps() -> Bool {
        for path in suspiciousAppsPathToCheck where FileManager.default.fileExists(atPath: path) {
            return true
        }
        return false
    }
}
