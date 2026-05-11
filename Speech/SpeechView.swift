//
//  SpeechView.swift
//  Speech
//
//  Created by ELENA INES HERNANDEZ on 20/4/26.
//
import SwiftUI

struct SpeechView: View {
    
    @StateObject var speech = SpeechRecognizer()
    @State private var isRecording = false
    
    var body: some View {
        ZStack {
            
            LinearGradient(
                gradient: Gradient(colors: [
                    Color.pink,
                    Color.blue,
                ]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            VStack(spacing: 30) {
                
                Text("Dictado en vivo")
                    .foregroundColor(.white)
                
                ScrollView {
                    Text(speech.transcript.isEmpty ? "Empieza a hablar..." : speech.transcript)
                        .foregroundColor(.white)
                        .padding()
                }
                .frame(height: 200)
                
                // 🎙 BOTÓN GRABAR / DETENER
                Button(action: {
                    if isRecording {
                        speech.stopRecording()
                    } else {
                        speech.startRecording()
                    }
                    isRecording.toggle()
                }) {
                    Image(systemName: isRecording ? "stop.fill" : "mic.fill")
                        .resizable()
                        .frame(width: 60, height: 80)
                        .foregroundColor(.white)
                }
                
                // 💾 BOTÓN OPCIONAL GUARDAR
                Button("Guardar texto") {
                    speech.saveToHistory()
                }
                .foregroundColor(.white)
            }
        }
    }
}
