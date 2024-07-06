#Preview { SplashView() }

import SwiftUI

struct SplashView: View {
    
    @State private var vm = ViewModel()
    @State private var auth = false
    
    let widthScreen = UIScreen.main.bounds.width
    
    init() {
        
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.black
                    .ignoresSafeArea()
                
                VStack {
                    
                    Spacer()
                    
                    Image("logo_frame")
                        .renderingMode(.template)
                        .foregroundColor(._yellow)
                        .aspectRatio(contentMode: .fill)
                        .frame(width: widthScreen / 2)
                        .frame(height: widthScreen / 2)
                        .frame(alignment: .center)
                        .clipped()
                    
                    Spacer()
                    
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                        .scaleEffect(1.5)
                    
                    Spacer()
                    
                    Text(vm.getVersionApp())
                        .foregroundStyle(.white.opacity(0.3))
                        .multilineTextAlignment(.center)
                        .font(.custom_(.rootUI_Bold, size: 14))
                }
//                .onAppear {
//                    DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
//                        print("---")
//                        self.auth = true
//                    }
//                }
//                .fullScreenCover(isPresented: $auth, content: {
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
}


extension SplashView {
    @Observable
    class ViewModel {
        
        func getVersionApp() -> String {
            let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] ?? "-"
            return "\(appVersion)"
        }
    }
}
