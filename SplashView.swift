#Preview { SplashView() }

import SwiftUI

struct SplashView: View {
    
    @StateObject var vm = ViewModelSplashView()
    
    let widthScreen = UIScreen.main.bounds.width
    
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
            }
            .fullScreenCover(isPresented: $vm.showEnterCodeTenant, content: {
                NavigationView { InputTenantView() }
            })
        }
    }
}


class ViewModelSplashView: ObservableObject {
    
    @Published var showEnterCodeTenant = false
    
    func getVersionApp() -> String {
        let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] ?? "-"
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            // проверка авторизации
            if Auth.checkAuth() == false {
                self.showEnterCodeTenant = true
            } else {
                self.getStartData()
            }
        }
        return "\(version)"
    }
    
    private func getStartData() {
        print("getStartData")
    }
}
