import SwiftUI

@main
struct VovlekayApp: App {
    
//    @State private var endDelay = false
    
    var body: some Scene {
        WindowGroup {
            SplashView()
//                .onAppear {
//                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
////                        self.endDelay = true
//                        SplashView()
//                    }
//                }
//                .fullScreenCover(isPresented: $endDelay, content: {
//                    NavigationView { InputTenantView() }
//                })
//                .sheet(isPresented: $auth) {
//                    NavigationView { InputTenantView() }
//                }
//                .navigationDestination(isPresented: $auth) {
//                    InputTenantView()
//                }
        }
    }
}
