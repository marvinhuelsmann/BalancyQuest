//
//  CompassChallengeView.swift
//  
//
//  Created by Marvin Hülsmann on 08.01.24.
//

import SwiftUI

struct CompassChallengeView: View {
    @Environment(\.presentationMode) var presentationMode
    
    /// location of the compass
    @State private var offset = CGSize.zero
    @State private var location: CGPoint = CGPoint(x: 550, y: 400)
    
    /// Distort the compass needle
    @State private var compassOffsetBoost = false
    
    /// Toggle if the user already find the magnets to toggle the sound from the compas
    @State private var alreadyDetectMagnets: Bool = false
    
    /// Offer the user the possibility to choose his direction that gives him the compass
    @State private var hasAbilityToChooseDirection: Bool = false
    @State private var chooseDirection: String = ""
    
    // Shows the user the information overlay
    @State private var showInformationOverlay: Bool = false
    
    var body: some View {
        VStack {
            GeometryReader { geometry in
                ZStack {
                    
                    Image("CompassChallenge")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: geometry.size.width * 1.3, height: geometry.size.height * 0.9)
                        .position(x: geometry.size.width / 2, y: geometry.size.height / 1.3)
                        .ignoresSafeArea()
                        .shadow(radius: 10)
                    
                    if chooseDirection != "Top Right" {
                        Image("Compass")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: geometry.size.width * 0.1, height: geometry.size.height * 0.2)
                            .padding()
                            .shadow(radius: 10)
                            .rotationEffect(.degrees(Double(location != CGPoint(x: 550, y: 400) ? (compassOffsetBoost ? offset.width / 1.8 : offset.width > 0 ? offset.width / 8 : (offset.width * -1) / 8) : Double.random(in: 0 ..< 360.0))))
                            .offset(x: offset.width / 2, y: offset.height / 2)
                            .position(location)
                            .scaleEffect(1.25)
                            .gesture(
                                DragGesture()
                                    .onChanged { gesture in
                                            withAnimation {
                                                offset = gesture.translation
                                                // Toggle compass to fake the compass view
                                                if (location.y > 615.5 && location.y < 755.5 && location.x > 0 && location.x < 350) {
                                                    compassOffsetBoost = true
                                                    alreadyDetectMagnets = true
                                                } else {
                                                    compassOffsetBoost = false
                                                }
                                                location.y = gesture.location.y + 10
                                                location.x = gesture.location.x + 10
                                            }
                                            
                                        }
                            )
                    }
                    
                    VStack {
                        HStack {
                        
                            VStack {
                                Image(systemName: "info")
                                    .frame(width: 40, height: 40)
                                    .font(.title3)
                                    .foregroundStyle(.white)
                                    .bold()
                                    .onTapGesture {
                                        withAnimation {
                                            showInformationOverlay.toggle()
                                        }
                                    }
                            }
                            .padding(0.3)
                            .background(.black.opacity(0.8))
                            .cornerRadius(15)
                           
                            
                            Image("Greg")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: geometry.size.width * 0.1, height: geometry.size.height * 0.2)
                            
                            Text(chooseDirection != "" ? (chooseDirection == "Top Right" ? "Oh yes, that was the right way\rto get to the boat and you didn't let\rthe magnets point you in the wrong direction." : "No, I think that wasn't the way,\rdon't let your compass near magnets that \rare near the palm tree.") : hasAbilityToChooseDirection ? "Now use the compass to\rdetermine the direction?" : "Find the way to our boat the compass\rshows us the way, but be careful\rmagnets can distort the compass needle.\rMove the compass to find the right direction")
                                .padding()
                                .foregroundStyle(.black)
                                .font(Font.custom("Pirata One", size: 22, relativeTo: .title))
                                .background(.white)
                                .cornerRadius(10)
                        }
                            
                        if chooseDirection == "Top Right" {
                            Button(action: {
                                withAnimation(.easeInOut) {
                                    presentationMode.wrappedValue.dismiss()
                                    playSound(sound: "Pling")
                                }
                            }) {
                                Text("Back to the map")
                            }
                            .buttonStyle(VintageButtonStyle())
                        } else if !hasAbilityToChooseDirection {
                            Button(action: {
                                withAnimation(.easeInOut) {
                                    hasAbilityToChooseDirection.toggle()
                                }
                            }) {
                                Text("Get more details")
                            }
                            .buttonStyle(VintageButtonStyle())
                        } else {
                            HStack {
                                Button(action: {
                                    withAnimation(.easeInOut) {
                                        chooseDirection = "Top Right"
                                        playSound(sound: "Correct")
                                    }
                                }) {
                                    Text("Top Right")
                                }
                                .buttonStyle(VintageButtonStyle())
                                Button(action: {
                                    withAnimation(.easeInOut) {
                                        chooseDirection = "Top Left"
                                        playSound(sound: "Bad")
                                    }
                                }) {
                                    Text("Top Left")
                                }
                                .buttonStyle(VintageButtonStyle())
                                Button(action: {
                                    withAnimation(.easeInOut) {
                                        chooseDirection = "Bottom Left"
                                        playSound(sound: "Bad")
                                    }
                                }) {
                                    Text("Bottom Left")
                                }
                                .buttonStyle(VintageButtonStyle())
                                Button(action: {
                                    withAnimation(.easeInOut) {
                                        chooseDirection = "Bottom Right"
                                        playSound(sound: "Bad")
                                    }
                                }) {
                                    Text("Bottom Right")
                                }
                                .buttonStyle(VintageButtonStyle())
                            }
                        }
                    }
                    .padding(.leading, 10)
                    .position(x: 285, y: 90)
                }
            }
        }
        .onChange(of: alreadyDetectMagnets) { newValue in
            /// A sound that can be interpreted for a compass needle spinner bug
            playSound(sound: "CompassMagnets")
        }
        .background(.blue)
        .overlay(content: {
            InformationOverlay(isVisible: $showInformationOverlay, title: "What affects a compass?", bodyText: "Magnets disrupt compasses because\rthey create a magnetic field that confuses the needle,\rleading it away from the true direction.")
        })
    }
}

#Preview {
    CompassChallengeView()
}
