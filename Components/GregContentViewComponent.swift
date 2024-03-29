//
//  GregContentViewComponent.swift
//
//
//  Created by Marvin Hülsmann on 13.01.24.
//

import SwiftUI

struct GregContentViewComponent: View {
    @State private var challengeCount: Int = 0
    @State var gameEngine: GameEngine
    @State var geometry: GeometryProxy
    
    @State private var openCompassChallenge: Bool = false
    @State private var openSeekChallenge: Bool = false
    @State private var openJungleChallenge: Bool = false
    @State private var openLightTowerView: Bool = false
    
    var body: some View {
        VStack {
            if gameEngine.currentGameState == .welcome {
                if challengeCount <= 2 {
                    ZStack(alignment: .bottomLeading) {
                        VStack {
                            HStack {
                                Image("Greg")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: geometry.size.width * 0.1, height: geometry.size.height * 0.2)
                                Spacer()
                            }
                            
                            HStack {
                                Text(challengeCount == 0 ? "Ahoy my name is \(Text("Greg").bold().italic()), you stranded\rhere, I can help your to survive\rand can give your some useful tips." : challengeCount == 1 ? "You must follow the path for me, ok?" : "To start a challenge,\ryou can click on it on the map")
                                    .padding()
                                    .foregroundStyle(.black)
                                    .font(Font.custom("Pirata One", size: 22, relativeTo: .title))
                                    .background(.white)
                                    .cornerRadius(10)
                                
                                VStack {
                                    Button(action: {
                                        // To get further informations about the story from Greg
                                        withAnimation(.easeInOut) {
                                            challengeCount += 1
                                        }
                                    }) {
                                        Text("Next")
                                    }
                                    .buttonStyle(VintageButtonStyle())
                                }
                                
                                Spacer()
                            }
                            
                            
                            
                            
                        }
                        .position(x: geometry.size.width / 1.95, y: geometry.size.height / 1.25)
                        
                        
                    }
                }
                
                
                /// Challenge start position
                if challengeCount > 2 {
                    Rectangle()
                        .background(.black)
                        .opacity(0.2)
                        .frame(width: 35, height: 35)
                        .cornerRadius(10)
                        .offset(x: geometry.size.height == 700 ? -30 : geometry.size.height > 931.5 ? -41 : -34, y: getScreenSize(height: geometry.size.height))
                        .onTapGesture {
                            
                            /// Updating cucrent gameState
                            gameEngine.updateGameState()
                            challengeCount = 0
                            
                            openCompassChallenge.toggle()
                            
                        }
                }
                
            } else if gameEngine.currentGameState == .compass || gameEngine.currentGameState == .seek {
                ZStack(alignment: .bottomLeading) {
                    VStack {
                        HStack {
                            Image("Greg")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: geometry.size.width * 0.1, height: geometry.size.height * 0.2)
                            Spacer()
                        }
                        
                        HStack {
                            Text("Now we have to move on, start the next \(Text("challenge").bold().italic())!")
                                .foregroundStyle(.black)
                                .padding()
                                .font(Font.custom("Pirata One", size: 22, relativeTo: .title))
                                .background(.white)
                                .cornerRadius(10)
                            
                            Spacer()
                        }
                        
                        
                    }
                    .onTapGesture {
                        challengeCount = 1
                    }
                    .position(x: geometry.size.width / 1.95, y: geometry.size.height / 1.25)
                    
                }
                
                // Challenge start position
                
                Rectangle()
                    .background(.black)
                    .opacity(0.2)
                    .frame(width: 40, height: 40)
                    .cornerRadius(10)
                    .position(x: geometry.size.height == 700 ? 640 : geometry.size.height > 931.5 ? 785 : 680, y: getScreenSize(height: geometry.size.height))
                    .onTapGesture {
                        playSound(sound: "Alert")
                        
                        /// Updating cucrent gameState
                        gameEngine.updateGameState()
                        challengeCount = 0
                        
                        /// Updating view
                        openSeekChallenge.toggle()
                    }
                
                
                
                
            } else if gameEngine.currentGameState == .jungle {
                ZStack(alignment: .bottomLeading) {
                    VStack {
                        HStack {
                            Image("Greg")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: geometry.size.width * 0.1, height: geometry.size.height * 0.2)
                            Spacer()
                        }
                        
                        HStack {
                            Text("Now we are in front of the\rjungle, but be careful there\rare many dangerous animals there!")
                                .padding()
                                .foregroundStyle(.black)
                                .font(Font.custom("Pirata One", size: 22, relativeTo: .title))
                                .background(.white)
                                .cornerRadius(10)
                            
                            Spacer()
                        }
                        
                        
                    }
                    .onTapGesture {
                        challengeCount = 1
                    }
                    .position(x: geometry.size.width / 1.95, y: geometry.size.height / 1.25)
                    
                }
                
                Rectangle()
                    .background(.black)
                    .opacity(0.25)
                    .frame(width: 130, height: 80)
                    .cornerRadius(15)
                    .position(x: geometry.size.height > 931.5 ? 465 : 415, y: getScreenSize(height: geometry.size.height))
                    .onTapGesture {
                        playSound(sound: "Bad")
                        openJungleChallenge.toggle()
                        
                        /// Updating cucrent gameState
                        gameEngine.updateGameState()
                        challengeCount = 0
                    }
            } else if gameEngine.currentGameState == .lighttower {
                ZStack(alignment: .bottomLeading) {
                    VStack {
                        HStack {
                            Image("Greg")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: geometry.size.width * 0.1, height: geometry.size.height * 0.2)
                            Spacer()
                        }
                        
                        HStack {
                            Text("The final task is to get along the\rlighthouse, it's not as easy as it seems.")
                                .foregroundStyle(.black)
                                .padding()
                                .font(Font.custom("Pirata One", size: 22, relativeTo: .title))
                                .background(.white)
                                .cornerRadius(10)
                            
                            Spacer()
                        }
                        
                        
                    }
                    .onTapGesture {
                        challengeCount = 1
                    }
                    .position(x: geometry.size.width / 1.95, y: geometry.size.height / 1.25)
                    
                }
                
                Rectangle()
                    .background(.black)
                    .opacity(0.2)
                    .frame(width: 50, height: 95)
                    .cornerRadius(10)
                    .position(x: geometry.size.height == 700 ? 525 : geometry.size.height > 931.5 ? 625 : 550, y: getScreenSize(height: geometry.size.height))
                    .onTapGesture {
                        playSound(sound: "Bad")
                        openLightTowerView.toggle()
                        
                        /// Updating cucrent gameState
                        gameEngine.updateGameState()
                        challengeCount = 0
                    }
            }
        }
        .fullScreenCover(isPresented: $openCompassChallenge, onDismiss: {
            /// Updating current game state
            gameEngine.setGameState(newGameState: .seek)
            print(gameEngine.currentGameState)
        }, content: {
            CompassChallengeView()
        })
        .fullScreenCover(isPresented: $openJungleChallenge, onDismiss: {
            /// Updating current game state
            gameEngine.setGameState(newGameState: .lighttower)
            print(gameEngine.currentGameState)
        }, content: {
            JungleChallengeView()
        })
        .fullScreenCover(isPresented: $openSeekChallenge, onDismiss: {
            /// Updating current game state
            gameEngine.setGameState(newGameState: .jungle)
            challengeCount = 2
            print(gameEngine.currentGameState)
        }, content: {
            SeekChallengeView()
        })
        .fullScreenCover(isPresented: $openLightTowerView, onDismiss: {
            /// Updating current game state
            gameEngine.setGameState(newGameState: .boat)
            challengeCount = 2
            print(gameEngine.currentGameState)
        }, content: {
            LightTowerView()
        })
    }
    
    /// Get current screen height
    /// - Parameter height: Current screen height of the iPad
    /// - Returns: the y coordinate value as a CGFloat to bring the object in the correct position
    func getScreenSize(height: Double) -> CGFloat {
        print("Current height is \(height)")
        print("+ \(gameEngine.currentGameState)")
        switch gameEngine.currentGameState {
        case .welcome:
            // Compass icon
            if height == 700 {
                return 62
            } else if height > 931.5 {
                return 95
            } else {
                return 73
            }
        case .compass:
            // Seek icon
            if height == 700 {
                return 110
            } else if height > 931.5 {
                return 173
            } else {
                return 130
            }
        case .seek:
            // Jungle icon
            if height == 700 {
                return -95
            } else if height > 931.5 {
                return -93
            } else {
                return -100
            }
        case .jungle:
            // lighttower icon
            if height == 700 {
                return -95
            } else if height > 931.5 {
                return -93
            } else {
                return -100
            }
        case .lighttower:
            // lighttower icon!
            if height == 700 {
                return -215
            } else if height > 931.5 {
                return -285
            } else {
                return -235
            }
        case .boat:
            if height > 931.5 {
                return 224
            } else {
                return 178
            }
        }
        
        
    }
}

