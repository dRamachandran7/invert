//
//  Screen++.swift
//  Invert
//
//  Created by Dhruva Ramachandran on 6/3/24.
//

import Foundation
import SwiftUI

#if os(iOS) || os(tvOS)
class Screen {
    static var safeArea: UIEdgeInsets = UIScreen.safeArea
}
fileprivate extension UIScreen {
    static var safeArea: UIEdgeInsets {
        UIApplication.shared
            .connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .flatMap(\.windows)
            .first(where: \.isKeyWindow)?
            .safeAreaInsets ?? .zero
    }
}

#elseif os(macOS)
class Screen {
    static var safeArea: NSEdgeInsets = NSScreen.safeArea
}
fileprivate extension NSScreen {
    static var safeArea: NSEdgeInsets =
    NSApplication.shared
        .mainWindow?
        .contentView?
        .safeAreaInsets ?? .init(top: 0, left: 0, bottom: 0, right: 0)
}
#endif
