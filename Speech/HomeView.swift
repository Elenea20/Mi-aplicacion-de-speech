//
//  HomeView.swift
//  Speech
//
//  Created by ELENA INES HERNANDEZ on 20/4/26.
//
import SwiftUI

struct HomeView: View {
    
    var body: some View {
        NavigationView {
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
                
                VStack(spacing: 30) {
                    
                    Text("Speech")
                        .font(.system(size: 35, weight: .bold))
                        .foregroundColor(.white)
                    
                    Text("Convierte tu voz en texto")
                        .foregroundColor(.white.opacity(0.8))
                    
                    NavigationLink(destination: SpeechView()) {
                        ZStack {
                            Circle()
                                .fill(Color.white.opacity(0.2))
                                .frame(width: 120, height: 120)
                            
                            Image(systemName: "mic.fill")
                                .resizable()
                                .frame(width: 40, height: 60)
                                .foregroundColor(.white)
                        }
                    }
                    
                    NavigationLink(destination: HistoryView()) {
                        Text("Ver Historial")
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.white)
                            .foregroundColor(.purple)
                            .cornerRadius(10)
                            .padding(.horizontal)
                    }
                }
            }
        }
    }
}
