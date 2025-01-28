import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = ContentViewModel()
    @State private var isShowingFavorites = false
    @State private var isShowingSettings = false
    
    var body: some View {
        ZStack {
            // Sfondi condizionali per piattaforma
            Group {
                if UIDevice.current.userInterfaceIdiom == .pad {
                    Image("Sfondo2")
                        .resizable()
                        .scaledToFill()
                        .edgesIgnoringSafeArea(.all)
                    .edgesIgnoringSafeArea(.all)
                } else {
                    // Se è un iPhone, usa l'immagine di sfondo
                    Image("Sfondo")
                        .resizable()
                        .scaledToFill()
                        .edgesIgnoringSafeArea(.all)
                }
            }
            VStack {
                // TITLE
                Text("Roastr")
                    .font(.system(size: 90))
                    .fontWeight(.bold)
                    .foregroundColor(Color(red: 0.32156863, green: 0.44313725, blue: 1.0))
                
                // ROAST
                Text(viewModel.selectedRoast)
                    .font(.system(size: 25))
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .padding(30)
                    .foregroundColor(.white)
                    .shadow(radius: 45)
                
                // ROAST GENERATOR BUTTON
                Button(action: { viewModel.generateRandomRoast() }) {
                    Text(viewModel.isEnglish ? "F**CK OFF!" : "VAFFANC!")
                        .font(.title)
                        .foregroundColor(.black)
                        .padding(.horizontal, 30)
                        .padding(.vertical, 20)
                        .background(Color.green.opacity(0.9))
                        .cornerRadius(45)
                        .shadow(radius: 45)
                }
                .padding(.top, 20)
                
                // STAR, SHARE and SETTINGS BUTTONS
                if !viewModel.selectedRoast.isEmpty {
                    HStack(spacing: 20) {
                        Button(action: { viewModel.toggleFavorite() }) {
                            Image(systemName: viewModel.favoriteRoasts.contains(viewModel.selectedRoast) ? "star.fill" : "star")
                                .resizable()
                                .frame(width: 20, height: 20)
                                .foregroundColor(viewModel.favoriteRoasts.contains(viewModel.selectedRoast) ? .yellow : .white)
                                .padding()
                                .background(Color.gray)
                                .clipShape(Circle())
                        }
                        
                        ShareButton(action: { shareRoast() })
                        
                        Button(action: { isShowingSettings = true }) {
                            Image(systemName: "gearshape.fill")
                                .resizable()
                                .frame(width: 20, height: 20)
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.gray)
                                .clipShape(Circle())
                        }
                        
                        Button(action: { viewModel.speakRoast() }) {
                            Image(systemName: "speaker.wave.2.fill")
                                .resizable()
                                .frame(width: 20, height: 20)
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.gray)
                                .clipShape(Circle())
                        }
                    }
                    .padding(.top, 20)
                }
                
                // FAVORITES BUTTON
                Button(action: { isShowingFavorites = true }) {
                    Text(viewModel.isEnglish ? "Favorites" : "Preferiti")
                        .font(.title2)
                        .foregroundColor(.white)
                        .padding(.horizontal, 15)
                        .padding(.vertical, 15)
                        .background(Color.blue)
                        .cornerRadius(18)
                        .shadow(radius: 10)
                }
                .padding(.top, 20)
            }
        }
        .sheet(isPresented: $isShowingFavorites) {
            FavoriteListView(favorites: $viewModel.favoriteRoasts, isShowingFavorites: $isShowingFavorites, isEnglish: $viewModel.isEnglish)
        }
        .sheet(isPresented: $isShowingSettings) {
            SettingsView(isEnglish: $viewModel.isEnglish, isShowingSettings: $isShowingSettings)
        }
    }
    
    private func shareRoast() {
        let activityController = UIActivityViewController(activityItems: viewModel.shareRoast(), applicationActivities: nil)
        
        // Ottieni la vista di origine (in questo caso, la vista principale della ContentView)
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let rootVC = windowScene.windows.first?.rootViewController {
            
            // Aggiungi la configurazione per sourceView su iPad
            if UIDevice.current.userInterfaceIdiom == .pad {
                activityController.popoverPresentationController?.sourceView = rootVC.view // Imposta la vista di origine
                activityController.popoverPresentationController?.sourceRect = CGRect(x: rootVC.view.bounds.midX, y: rootVC.view.bounds.midY, width: 1, height: 1) // Imposta una posizione centrale per l'apertura del popover
            }
            
            rootVC.present(activityController, animated: true, completion: nil)
        }
    }
}

