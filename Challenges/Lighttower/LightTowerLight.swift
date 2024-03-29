//
//  LightTowerLight.swift
//
//
//  Created by Marvin Hülsmann on 23.01.24.
//

import SwiftUI

struct LightTowerLight: View {
    @State private var isFlicking: Bool = false
    let timer = Timer.publish(every: 0.5, on: .main, in: .common).autoconnect()
    var body: some View {
        VStack {
            VStack {}
            .shadow(color: isFlicking ? .yellow : .clear, radius: 10)
            .brightness(isFlicking ? 0.5 : 1.0)
            .blur(radius: isFlicking ? 5 : 0)
            .frame(width: 75, height: 60)
            .background(Color.yellow.opacity(!isFlicking ? 0.05 : 0.15))
            .cornerRadius(20)
            .onReceive(timer) { input in
                withAnimation(.linear) {
                    isFlicking.toggle()
                    
                }
            }
        }
    }
}

#Preview {
    LightTowerLight()
}
