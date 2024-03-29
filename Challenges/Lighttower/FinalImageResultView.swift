//
//  FinalImageResultView.swift
//
//
//  Created by Marvin Hülsmann on 23.01.24.
//

import SwiftUI

struct FinalImageResultView: View {
    
    /// The image that the user took before this view
    @Binding var image: UIImage
    
    @State var showCreditOverlay: Bool = false
    @State var hasSavedImage: Bool = false
    
    var body: some View {
        VStack {
            GeometryReader { geometry in
                ZStack(alignment: .center) {
                    Image("BoatChallenge")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .ignoresSafeArea()
                    
                    VStack {
                        HStack {
                            Image(systemName: "person")
                                .frame(width: 40, height: 40)
                                .font(.title3)
                                .foregroundStyle(.white)
                                .bold()
                                .onTapGesture {
                                    withAnimation {
                                        showCreditOverlay.toggle()
                                    }
                                }
                                .padding(0.3)
                                .background(.black.opacity(0.8))
                                .cornerRadius(15)
                                .padding(.leading, 10)
                            Spacer()
                        }
                        
                        
                        Spacer()
                    }
                    
                    ZStack(alignment: .center) {
                        VStack {
                            HStack {
                                Spacer()
                                Image(uiImage: image)
                                    .resizable()
                                    .scaledToFit()
                                    .cornerRadius(25)
                                    .frame(width: 600, height: 500)
                                Spacer()
                            }
                            
                            HStack {
                                
                                
                                Image("Greg")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: geometry.size.width * 0.1, height: geometry.size.height * 0.2)
                                
                                Text(!hasSavedImage ? hasClosedEyes() ? "You had your eyes closed, you've made it!\rI hope you have learned something and know why\rsome things are very important and now you don't\rhave to ask Siri so much anymore!" : "You didn't close your eyes! But you've made the challenges!\rI hope you have learned something and know why some things\rare very important and now you don't have to ask Siri so much anymore!" : "You saved the picture\rand now I say see you soon!")
                                    .padding()
                                    .foregroundStyle(.black)
                                    .font(Font.custom("Pirata One", size: 22, relativeTo: .title))
                                    .background(.white)
                                    .cornerRadius(10)
                                
                                if !hasSavedImage {
                                    Button(action: {
                                        /// Save image to photo liabry
                                        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
                                        
                                        hasSavedImage = true
                                        showCreditOverlay = true
                                        
                                        /// Show end overlay
                                        playSound(sound: "WelcomeSound")
                                        
                                        
                                    }) {
                                        Text("Save image")
                                    }
                                    .buttonStyle(VintageButtonStyle())
                                }
                                
                                Spacer()
                            }
                            .padding(.top, 2)
                        }
                        .padding(.top, 10)
                    }
                }
            }
            .overlay {
                CreatorOverlay(isVisible: $showCreditOverlay)
            }
        }
    }
    
    /// Check if the user has closed his eyes
    /// - Returns: if he has closes both eyes
    func hasClosedEyes() -> Bool {
        let ciImage = CIImage(cgImage: image.cgImage!)
        
        let options = [CIDetectorAccuracy: CIDetectorAccuracyHigh]
        let faceDetector = CIDetector(ofType: CIDetectorTypeFace, context: nil, options: options)!
        
        let faces = faceDetector.features(in: ciImage, options: [CIDetectorEyeBlink: true])
        
        if let face = faces.first as? CIFaceFeature {
            /// See if there is a smile in the picture
            
            if face.leftEyeClosed && face.rightEyeClosed {
                return true
            }
        }
        return false
    }
}

