#Preview { Home() }

import SwiftUI

struct Home: View {
        
    var body: some View {
        NavigationStack {
            ZStack {
                Color.purple
                    .ignoresSafeArea()
                    .navigationBarBackButtonHidden()
            }
        }
    }
}
