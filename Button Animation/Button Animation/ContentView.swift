//
//  ContentView.swift
//  Button Animation
//
//  Created by Juvin R on 04/02/22.
//

import SwiftUI

struct ContentView: View {
    
    @State private var greenAnimationAmount = 0.0
    @State private var redAnimationAmount = 0.0
    
    var body: some View {
        VStack(spacing: 50) {
            
            // Green Button. It gets full touch area.
            Button {
                withAnimation {
                    greenAnimationAmount += 360
                }
            } label: {
                Text("Tap Me")
                    .padding(50)
                    .background(.green)
                    .foregroundColor(.white)
                    .clipShape(Circle())
            }
            .rotation3DEffect(.degrees(greenAnimationAmount), axis: (x: 1, y: 0, z: 0))
            
            // Red Button. It gets touch only on its text area.
            Button("Tap Me") {
                withAnimation {
                    redAnimationAmount += 360
                }
            }
            .padding(50)
            .background(.red)
            .foregroundColor(.white)
            .clipShape(Circle())
            .rotation3DEffect(.degrees(redAnimationAmount), axis: (x: 1, y: 0, z: 0))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
