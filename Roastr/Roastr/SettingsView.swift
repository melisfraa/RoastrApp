import SwiftUI

struct SettingsView: View {
    @Binding var isEnglish: Bool
    @Binding var isShowingSettings: Bool

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Language")) {
                    Toggle(isOn: $isEnglish) {
                        Text(isEnglish ? "English" : "Italiano")
                    }
                }

                Section(header: Text("About the App")) {
                    HStack {
                        Text("Version")
                        Spacer()
                        Text("1.0.0")
                            .foregroundColor(.gray)
                    }
                    HStack {
                        Text("Release Date")
                        Spacer()
                        Text("2025")
                            .foregroundColor(.gray)
                    }
                }

                Section(header: Text("Contact")) {
                    Button(action: {
                        if let url = URL(string: "mailto:roastrapp@example.com") {
                            UIApplication.shared.open(url)
                        }
                    }) {
                        HStack {
                            Image(systemName: "envelope")
                            Text("roastrapp@example.com")
                        }
                    }
                }
            }
            .navigationTitle("Settings")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Close") {
                        isShowingSettings = false
                    }
                }
            }
        }
    }
}

