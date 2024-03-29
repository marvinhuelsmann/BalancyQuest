//
//  LightTowerView.swift
//
//
//  Created by Marvin Hülsmann on 22.01.24.
//

import SwiftUI

struct LightTowerView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @State private var showInformationOverlay: Bool = false
    
    /// Device options for taking a photo
    @State private var sourceType: UIImagePickerController.SourceType = UIImagePickerController.isSourceTypeAvailable(.camera) ? .camera : .photoLibrary
    
    /// the photo taken by the user
    @State private var selectedImage: UIImage = UIImage(systemName: "pencil")!
    
    /// Check if the picker overlay is visible
    @State private var isImagePickerDisplay: Bool = false
    
    /// if the user has took a photo
    @State private var hasTakenImage: Bool = false
    
    var body: some View {
        VStack {
            GeometryReader { geometry in
                ZStack(alignment: .topLeading) {
                    
                    Image("LighttowerChallenge")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: geometry.size.width * 1.3, height: geometry.size.height * 0.9)
                        .position(x: geometry.size.width / 2, y: geometry.size.height / 1.3)
                        .ignoresSafeArea()
                    
                    LightTowerLight()
                        .position(CGPoint(x: 465.0, y: 340.0))
                    
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
                            
                            Text(selectedImage == UIImage(systemName: "pencil") ? "It is very bright here, keep moving with your\reyes closed so as not to be blinded by the light!" : "Ok let's move on, but keep your eyes partially closed")
                                .padding()
                                .foregroundStyle(.black)
                                .font(Font.custom("Pirata One", size: 22, relativeTo: .title))
                                .background(.white)
                                .cornerRadius(10)
                            
                            Button(action: {
                                // Open camera app
                                if selectedImage == UIImage(systemName: "pencil") {
                                    sourceType = UIImagePickerController.isSourceTypeAvailable(.camera) ? .camera : .photoLibrary
                                    isImagePickerDisplay.toggle()
                                } else {
                                    hasTakenImage = true
                                    playSound(sound: "Pling")
                                }
                            }) {
                                Text(selectedImage == UIImage(systemName: "pencil") ? "Start close your Eyes" : "Go")
                            }
                            .buttonStyle(VintageButtonStyle())
                            
                        }
                    }
                    .padding(.leading, 10)
                    
                }
            }
            .background(.blue)
            .sheet(isPresented: self.$isImagePickerDisplay) {
                ImagePickerView(selectedImage: $selectedImage, sourceType: self.sourceType)
            }
            .onChange(of: selectedImage) { newImage in
                if newImage != UIImage(systemName: "pencil") {
                    isImagePickerDisplay = false
                }
            }
            .fullScreenCover(isPresented: $hasTakenImage, content: {
                FinalImageResultView(image: $selectedImage)
            })
            .overlay(content: {
                InformationOverlay(isVisible: $showInformationOverlay, title: "Why is very strong light not good for the eyes?", bodyText: "Really bright lights, like the Lighttower, can hurt your eyes because they're so strong. Staring at them for a long time might make your eyes uncomfortable, tired, and could cause vision problems.")
            })
        }
    }
}

#Preview {
    LightTowerView()
}
