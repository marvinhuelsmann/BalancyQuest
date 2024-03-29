//
//  InformationOverlay.swift
//
//
//  Created by Marvin Hülsmann on 13.01.24.
//

import SwiftUI

struct InformationOverlay: View {
    /// Statement if the view is visible or is vanished
    @Binding var isVisible: Bool
    
    /// The title above the box indicating the topic
    @State var title: String
    /// The inner text in the box
    @State var bodyText: String

    var body: some View {
        if isVisible {
            ZStack {
                Group {
                    Rectangle()
                        .fill(.blue.opacity(0.89))
                        .blur(radius: 0)
                        .ignoresSafeArea()
                    
                    VStack {
                        HStack {
                            Spacer()
                            Text(title)
                                .foregroundColor(.black)
                                .fontWeight(.bold)
                                .font(.largeTitle)
                                .padding(.trailing, 3)
                            Text(bodyText)
                                .foregroundColor(.white)
                                .multilineTextAlignment(.center)
                                .fontWeight(.semibold)
                                .font(.title3)
                                .padding(30)
                                .background(.black.opacity(0.95), in: RoundedRectangle(cornerRadius: 10, style: .continuous))
                            Spacer()
                        }
                    }
                }
                Spacer()
            }
            .onTapGesture {
                withAnimation(.easeOut) {
                    isVisible.toggle()
                }
            }
        }
    }
}

