//
//  ButtonStyleContent.swift
//  Splitter
//
//  Created by Vikas Salian on 16/11/24.
//

import SwiftUI

public struct ButtonStyleContent<Content: View>: View {
    public typealias ContentBuilder = (_ isEnabled: Bool) -> Content

    private let viewBuilder: ContentBuilder

    @SwiftUI.Environment(\.isEnabled)
    private var isEnabled: Bool

    public init(@ViewBuilder viewBuilder: @escaping ContentBuilder) {
        self.viewBuilder = viewBuilder
    }

    public var body: some View {
        viewBuilder(isEnabled)
    }
}
