//
//  CreatorOverlay.swift
//
//
//  Created by Marvin Hülsmann on 24.01.24.
//

import SwiftUI

struct CreatorOverlay: View {
    /// Statement if the view is visible or is vanished
    @Binding var isVisible: Bool

    var body: some View {
        if isVisible {
            ZStack(alignment: .top) {
                Group {
                    Rectangle()
                        .fill(.red.opacity(0.90))
                        .blur(radius: 0)
                        .ignoresSafeArea()
                    
                    VStack {
                        VStack {
                            Spacer()
                            Text("BalancyQuest")
                                .foregroundColor(.white)
                                .fontWeight(.semibold)
                                .textCase(.uppercase)
                                .multilineTextAlignment(.center)
                                .font(.body)
                                .padding(.bottom, -4)
                            Text("Thanks for playing")
                                .foregroundColor(.white)
                                .font(.largeTitle)
                                .fontWeight(.heavy)
                                .padding(.bottom, 5)
                            Text("I hope you were able to gather some more information,\rlaugh a bit and find some details in this Swift Playground.")
                                .foregroundColor(.white)
                                .multilineTextAlignment(.center)
                                .fontWeight(.semibold)
                                .font(.title3)
                                .padding(30)
                                .background(.black.opacity(0.75), in: RoundedRectangle(cornerRadius: 10, style: .continuous))
                            
                            Spacer()
                        }
                        Text("Developed by Marvin Hülsmann in Germany\rfor the Swift Student Challenge 2024")
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                            .fontWeight(.medium)
                            .textCase(.uppercase)
                            .font(.footnote)
                            .padding(.bottom, -4)
                    }
                }
                Spacer()
            }
            .onTapGesture {
                withAnimation {
                    isVisible.toggle()
                }
            }
        }
    }
}

#Preview {
    CreatorOverlay(isVisible: .constant(true))
}
