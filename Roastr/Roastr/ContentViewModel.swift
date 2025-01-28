import Foundation
import AVFoundation

class ContentViewModel: ObservableObject {
    @Published var isEnglish = false
    @Published var selectedRoast = ""
    @Published var favoriteRoasts: [String] {
        didSet {
            saveFavorites()
        }
    }
    
    private var roasts: [String] {
        isEnglish ? EnglishRoasts.all : Roasts.all
    }
    
    init() {
        self.favoriteRoasts = UserDefaults.standard.stringArray(forKey: "favorites") ?? []
    }
    
    private func saveFavorites() {
        UserDefaults.standard.set(favoriteRoasts, forKey: "favorites")
    }
    
    func generateRandomRoast() {
        let randomIndex = Int.random(in: 0..<roasts.count)
        selectedRoast = roasts[randomIndex]
    }
    
    func toggleFavorite() {
        if favoriteRoasts.contains(selectedRoast) {
            favoriteRoasts.removeAll { $0 == selectedRoast }
        } else {
            favoriteRoasts.append(selectedRoast)
        }
    }
    
    func speakRoast() {
        let utterance = AVSpeechUtterance(string: selectedRoast)
        utterance.voice = AVSpeechSynthesisVoice(language: isEnglish ? "en-US" : "it-IT")
        utterance.rate = 0.5
        
        let synthesizer = AVSpeechSynthesizer()
        synthesizer.speak(utterance)
    }
    
    func shareRoast() -> [Any] {
        return [selectedRoast]
    }
}

