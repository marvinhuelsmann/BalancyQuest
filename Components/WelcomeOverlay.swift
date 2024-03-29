//
//  WelcomeOverlay.swift
//
//
//  Created by Marvin Hülsmann on 19.01.24.
//

import SwiftUI

struct WelcomeOverlay: View {
    /// Statement if the view is visible or is vanished
    @Binding var isVisible: Bool
    
    /// Check if the user has clicked in the canvas to prevent multiply sound effects
    @State var hasClicked: Bool = false

    var body: some View {
        if isVisible {
            ZStack {
                Group {
                    Rectangle()
                        .fill(.blue.opacity(0.90))
                        .blur(radius: 0)
                        .ignoresSafeArea()
                    
                    VStack {
                        VStack {
                            Spacer()
                            Text("Here you will learn everything about\rsurvival if your iPhone doesn't work.\r(Which of course won't happen)")
                                .foregroundColor(.white)
                                .fontWeight(.semibold)
                                .textCase(.uppercase)
                                .multilineTextAlignment(.center)
                                .font(.body)
                                .padding(.bottom, -4)
                            Text("Welcome to BalancyQuest!")
                                .foregroundColor(.white)
                                .font(.largeTitle)
                                .fontWeight(.heavy)
                                .padding(.bottom, 5)
                            Text("Here you will learn in bullet points\rwith Greg how you can move safely\rin the wilderness without any aids.")
                                .foregroundColor(.white)
                                .multilineTextAlignment(.center)
                                .fontWeight(.semibold)
                                .font(.title3)
                                .padding(30)
                                .background(.black.opacity(0.75), in: RoundedRectangle(cornerRadius: 10, style: .continuous))
                            
                            VStack {
                                Button(action: {
                                    startJourney()
                                }, label: {
                                    Text("Start Journey")
                                })
                                .buttonStyle(VintageButtonStyle())
                            }
                            Spacer()
                        }
                        Text("To get the most out of this Swift Playground,\rturn on the sound and stay in landscape mode")
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
                startJourney()
            }
        }
    }
    
    /// Ends the WelcomeOverlay and start the MapView
    func startJourney() {
        if !hasClicked {
            hasClicked = true
            playSound(sound: "WelcomeSound")
            withAnimation(.easeOut(duration: 4)) {
                isVisible.toggle()
            }
        }
    }
}
