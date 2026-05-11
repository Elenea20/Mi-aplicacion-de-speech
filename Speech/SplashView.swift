//
//  SplashView.swift
//  Speech
//
//  Created by ELENA INES HERNANDEZ on 20/4/26.
//
import SwiftUI

struct SplashView: View {
    
    @State private var isActive = false
    @State private var scale: CGFloat = 0.8
    @State private var opacity = 0.5
    
    var body: some View {
        
        if isActive {
            HomeView()
        } else {
            ZStack {
                
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color.blue,
                        Color.purple,
                        Color.pink
                    ]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                VStack(spacing: 20) {
                    
                    Image(systemName: "mic.fill")
                        .resizable()
                        .frame(width: 100, height: 140)
                        .foregroundColor(.white)
                        .scaleEffect(scale)
                    
                    Text("Speech")
                        .font(.system(size: 40, weight: .bold))
                        .foregroundColor(.white)
                        .opacity(opacity)
                }
            }
            .onAppear {
                
                withAnimation(.easeIn(duration: 1.2)) {
                    scale = 1.0
                    opacity = 1.0
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                    withAnimation {
                        isActive = true
                    }
                }
            }
        }
    }
}
