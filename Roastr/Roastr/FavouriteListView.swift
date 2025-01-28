import SwiftUI

struct FavoriteListView: View {
    @Binding var favorites: [String]
    @Binding var isShowingFavorites: Bool
    @Binding var isEnglish: Bool

    var body: some View {
        NavigationView {
            ZStack {
                Color.black.edgesIgnoringSafeArea(.all)
                List {
                    ForEach(favorites, id: \.self) { roast in Text(roast)
                    }
                    .onDelete(perform: removeFavorites)
                }
                .listStyle(InsetGroupedListStyle())
            }
            .navigationTitle(isEnglish ? "Favorites" : "Frasi Preferite")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(isEnglish ? "Close" : "Chiudi") {
                        isShowingFavorites = false
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
            }
        }
    }

    private func removeFavorites(at offsets: IndexSet) {
        favorites.remove(atOffsets: offsets)
    }
}

