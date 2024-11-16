//
//  LoadingIndicator.swift
//  Splitter
//
//  Created by Vikas Salian on 01/11/24.
//

import SwiftUI

public struct LoadingIndicator: View {
    public init() {}
    
    public var body: some View {
        ZStack {
            Color.black.opacity(0.2)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Spacer()
                
                RoundedRectangle(cornerRadius: 20)
                    .frame(width: 180, height: 180)
                    .foregroundColor(Color.white)
                    .overlay(
                        ProgressView()
                    )
                
                Spacer()
            }
        }
    }
}

#Preview {
    LoadingIndicator()
}

