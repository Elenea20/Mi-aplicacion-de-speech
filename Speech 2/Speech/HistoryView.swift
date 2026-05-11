//
//  HistoryView.swift
//  Speech
//
//  Created by ELENA INES HERNANDEZ on 20/4/26.
//
import SwiftUI

struct HistoryView: View {
    
    @State private var history: [String] = []
    
    var body: some View {
        
        ZStack {
            
           
            LinearGradient(
                gradient: Gradient(colors: [
                ]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            VStack {
                
    
                List {
                    ForEach(history, id: \.self) { item in
                        
                        Text(item)
                            .padding(5)
                    }
                }
                .background(Color.clear)
                
                // 🗑 BOTÓN BORRAR HISTORIAL
                Button(action: {
                    history.removeAll()
                    UserDefaults.standard.set(history, forKey: "history")
                }) {
                    
                    Text("Borrar Historial")
                        .font(.headline)
                        .foregroundColor(.black)
                        .padding()
                        .frame(width: 220)
                        .cornerRadius(15)
                }
                .padding(.bottom, 40) 
                
            }
        }
        .navigationTitle("Historial")
        .onAppear {
            loadHistory()
        }
    }
    
    func loadHistory() {
        history = UserDefaults.standard.stringArray(forKey: "history") ?? []
    }
}

// 👇 PREVIEW
struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            HistoryView()
        }
    }
}
