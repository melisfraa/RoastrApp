import SwiftUI

struct ShareButton: View {
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            Image(systemName: "square.and.arrow.up")
                .resizable()
                .frame(width: 20, height: 20)
                .foregroundColor(.white)
                .padding()
                .background(Color.gray)
                .clipShape(Circle())
        }
    }
}

