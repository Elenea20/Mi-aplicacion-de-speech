//
//  SpeechRecognizer.swift
//  Speech
//
//  Created by ELENA INES HERNANDEZ on 20/4/26.
//)
import Foundation
import Speech
import AVFoundation

class SpeechRecognizer: ObservableObject {
    
    private let recognizer = SFSpeechRecognizer(locale: Locale(identifier: "es-ES"))
    private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    private var recognitionTask: SFSpeechRecognitionTask?
    private let audioEngine = AVAudioEngine()
    
    @Published var transcript = ""
    
    // 🎙 INICIAR GRABACIÓN
    func startRecording() {
        transcript = ""
        
        // Limpiar si ya estaba corriendo
        if audioEngine.isRunning {
            audioEngine.stop()
            recognitionRequest?.endAudio()
            audioEngine.inputNode.removeTap(onBus: 0)
        }
        
        let node = audioEngine.inputNode
        let format = node.outputFormat(forBus: 0)
        
        recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
        
        guard let recognitionRequest = recognitionRequest else { return }
        
        recognitionTask = recognizer?.recognitionTask(with: recognitionRequest) { result, error in
            
            if let result = result {
                DispatchQueue.main.async {
                    self.transcript = result.bestTranscription.formattedString
                }
            }
        }
        
        node.installTap(onBus: 0, bufferSize: 1024, format: format) { buffer, _ in
            recognitionRequest.append(buffer)
        }
        
        audioEngine.prepare()
        try? audioEngine.start()
    }
    
    // ⏹ DETENER GRABACIÓN
    func stopRecording() {
        audioEngine.stop()
        recognitionRequest?.endAudio()
        audioEngine.inputNode.removeTap(onBus: 0)
        
        recognitionTask?.cancel()
        recognitionTask = nil
        
        saveToHistory() // 💾 Guardar automáticamente
    }
    
    // 💾 GUARDAR EN HISTORIAL
    func saveToHistory() {
        let key = "history"
        
        var history = UserDefaults.standard.stringArray(forKey: key) ?? []
        
        let cleanText = transcript.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !cleanText.isEmpty else { return }
        
        history.insert(cleanText, at: 0)
        
        UserDefaults.standard.set(history, forKey: key)
    }
}
