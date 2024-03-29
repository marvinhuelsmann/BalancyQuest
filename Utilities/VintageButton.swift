//
//  VintageButton.swift
//  BalancyQuest
//
//  Created by Marvin Hülsmann on 05.12.23.
//

import SwiftUI

struct VintageButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        VintageButton(configuration: configuration)
    }
    
    struct VintageButton: View {
        @Environment(\.controlSize) var controlSize
        
        let configuration: ButtonStyle.Configuration
        
        var body: some View {
            let isPressed = configuration.isPressed
            
            return configuration.label
                .padding(10)
                .background(isPressed ? Color.gray : Color(uiColor: UIColor.systemBrown))
                .foregroundColor(.white)
                .cornerRadius(8)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.white, lineWidth: 2)
                        .opacity(isPressed ? 0.5 : 0)
                )
                .scaleEffect(isPressed ? 0.8 : 1.0)
        }
    }
}
