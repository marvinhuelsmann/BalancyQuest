//
//  SeekChallengeView.swift
//
//
//  Created by Marvin Hülsmann on 14.01.24.
//

import SwiftUI

struct SeekChallengeView: View {
    @Environment(\.presentationMode) var presentationMode
    
    /// location of the stone
    @State private var offset = CGSize.zero
    @State private var location: CGPoint = CGPoint(x: 420, y: 215)
    
    // Shows the user the information overlay
    @State private var showInformationOverlay: Bool = false
    
    var body: some View {
        VStack {

            GeometryReader { geometry in
                ZStack(alignment: .top) {
                    
                    Image("SeekChallenge")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .ignoresSafeArea()
                    
                    ZStack(alignment: .top) {
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
                                
                                Text(location == CGPoint(x: 420, y: 215) ? "You have to find the water bottle and pick it up,\ras we die of thirst very quickly here\r in the desert, push the stone away!" : "Yes, now you can pick up the water bottle!")
                                    .padding()
                                    .foregroundStyle(.black)
                                    .font(Font.custom("Pirata One", size: 22, relativeTo: .title))
                                    .background(.white)
                                    .cornerRadius(10)
                            }
                        }
                        .ignoresSafeArea()
                        .padding([.bottom, .leading], 10)
                        
                    }
                    
                    Button(action: {
                        /// Check if the stone has another position
                        if location != CGPoint(x: 420, y: 215) {
                            playSound(sound: "Pling")
                            
                            presentationMode.wrappedValue.dismiss()
                        }
                    }) {
                        Rectangle()
                            .opacity(0)
                    }
                    .frame(width: 200, height: 180)
                    .position(CGPoint(x: 340, y: 125))
                    
                    Image("Stone")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: geometry.size.width * 0.1, height: geometry.size.height * 0.2)
                        .padding()
                        .scaleEffect(2.9)
                        .shadow(radius: 10)
                        .offset(x: offset.width / 2, y: offset.height / 2)
                        .position(location)
                        .gesture(
                            DragGesture()
                                .onChanged { gesture in
                                    withAnimation {
                                        offset = gesture.translation
                                        location.y = gesture.location.y - 7
                                        location.x = gesture.location.x - 7
                                    }
                                    
                                }
                        )
                    
            
                }
            }
        }
        .overlay(content: {
            InformationOverlay(isVisible: $showInformationOverlay, title: "Why it's important\rto drink water?", bodyText: "In the desert, it's super important to drink enough water. The hot and dry conditions can make you lose water quickly, and staying hydrated helps your body stay cool, work properly, and avoid serious health issues. So, always remember to drink plenty of water when you're in the desert!")
        })
    }
}

#Preview {
    SeekChallengeView()
}
