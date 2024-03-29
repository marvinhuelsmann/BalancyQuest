//
//  JungleChallengeView.swift
//
//
//  Created by Marvin Hülsmann on 21.01.24.
//

import SwiftUI

struct JungleChallengeView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @State private var showInformationOverlay: Bool = false
    
    /// Current visible lines
    @State private var lines = [Line(points: [CGPoint(x: 10, y: 10)], color: .black, lineWidth: 5)]
    
    @State private var hasInteractWithSpider: Bool = false
    /// Check if the user has the possibility to draw on the view
    @State private var isDrawing: Bool = false
    
    /// Check if the user has arrived at the top of the device with the line
    @State private var hasReachedTarget = false
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .topLeading) {
                
                Image("JungleChallenge")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .ignoresSafeArea()
                
                ZStack(alignment: .top) {
                    if !isDrawing {
                        VStack {
                            HStack {
                                VStack {
                                    Image(systemName: "info")
                                        .frame(width: 40, height: 40)
                                        .font(.title3)
                                        .foregroundStyle(.white)
                                        .bold()
                                }
                                .padding(0.3)
                                .background(.black.opacity(0.8))
                                .cornerRadius(15)
                                .onTapGesture {
                                    withAnimation {
                                        showInformationOverlay.toggle()
                                    }
                                }
                                
                                Image("Greg")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: geometry.size.width * 0.1, height: geometry.size.height * 0.2)
                                
                                Text(!hasReachedTarget ? "Here is a map where dangerous animals are often positioned, draw\ra path that we have to go we come from below and have to go up\rbut let us go far away from the evil animals and not through trees!" : "You have successfully managed to find a route\rthat does not involve any dangerous animals nearby")
                                    .padding()
                                    .foregroundStyle(.black)
                                    .font(Font.custom("Pirata One", size: 22, relativeTo: .title))
                                    .background(.white)
                                    .cornerRadius(10)
                                
                                Button(action: {
                                    if !hasReachedTarget {
                                        playSound(sound: "Pling")
                                        isDrawing = true
                                        hasInteractWithSpider = false
                                        lines = []
                                    } else {
                                        presentationMode.wrappedValue.dismiss()
                                    }
                                }) {
                                    Text(!hasReachedTarget ? "Start drawing" : "Back to map")
                                }
                                .buttonStyle(VintageButtonStyle())
                            }
                            
                        }
                        .ignoresSafeArea()
                        .padding([.bottom, .leading], 10)
                    } else {
                        HStack {
                            VStack {
                                Image(systemName: "trash")
                                    .frame(width: 40, height: 40)
                                    .font(.title3)
                                    .foregroundStyle(.white)
                                    .bold()
                            }
                            .padding(0.3)
                            .background(.black.opacity(0.8))
                            .cornerRadius(15)
                            .onTapGesture {
                                withAnimation {
                                    lines = []
                                }
                            }
                            .padding([.bottom, .leading], 10)
                            
                            Text("To draw the path you can use\ryour finger or an Apple Pencil")
                                .foregroundColor(.white)
                                .multilineTextAlignment(.leading)
                                .fontWeight(.medium)
                                .textCase(.uppercase)
                                .font(.footnote)
                                .padding(.bottom, 4)
                        }
                    }
                    
                }
                .zIndex(1)
                
                if isDrawing {
                    PathComponent(lines: $lines, hasInteractWithSpider: $hasInteractWithSpider, hasReachedTarget: $hasReachedTarget)
                }
                
                ForEach(0..<5) { index in
                    Image("Spider")
                        .resizable()
                        .position(getSpiderPosition(spiderCount: index))
                        .frame(width: 120, height: 120)
                }
                
            }
        }
        .onChange(of: hasInteractWithSpider) { newValue in
            if newValue {
                playSound(sound: "Bad")
                withAnimation {
                    isDrawing = false
                }
            }
        }
        .onChange(of: hasReachedTarget) { newValue in
            if newValue {
                playSound(sound: "Correct")
                withAnimation {
                    isDrawing = false
                }
            }
        }
        .overlay(content: {
            InformationOverlay(isVisible: $showInformationOverlay, title: "What is dangerous in the jungle?", bodyText: "In the jungle there are many different animals with different levels of danger; you could encounter dangerous spiders or snakes that carry dangerous poisons.")
        })
}

/// Returns certain CGPoints on which the spiders are then located
/// - Returns: CGPoint of the Spider
func getSpiderPosition(spiderCount: Int) -> CGPoint {
    switch spiderCount {
    case 0:
        return CGPoint(x: 260, y: 240)
    case 1:
        return CGPoint(x: 1040, y: 540)
    case 2:
        return CGPoint(x: 460, y: 180)
    case 3:
        return CGPoint(x: 1109, y: 290)
    case 4:
        return CGPoint(x: 650, y: 350)
    default:
        return CGPoint(x: 0, y: 0)
    }
}
}

#Preview {
    JungleChallengeView()
}
