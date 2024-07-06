import SwiftUI

@main
struct VovlekayApp: App {
    
    @State private var endDelay = false
    
    var body: some Scene {
        WindowGroup {
            SplashView()
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                        print("---")
                        self.endDelay = true
                    }
                }
                .fullScreenCover(isPresented: $endDelay, content: {
                    NavigationView { InputTenantView() }
                })
//                .sheet(isPresented: $auth) {
//                    NavigationView { InputTenantView() }
//                }
//                .navigationDestination(isPresented: $auth) {
//                    InputTenantView()
//                }
        }

    }
}
