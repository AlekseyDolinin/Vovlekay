#Preview { SplashView() }

import SwiftUI

struct SplashView: View {
    
    @StateObject var vm = SplashViewModel()
    @State private var authIsSucces = false
    
    let widthScreen = UIScreen.main.bounds.width
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.black
                    .ignoresSafeArea()
                    .onAppear {
                        vm.getVersionApp()
                    }
                VStack {
                    Spacer()
                    Image("logo_frame")
                        .renderingMode(.template)
                        .foregroundColor(.BB_PrimaryUI)
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
                    Text("\($vm.infoApp.wrappedValue)")
                        .foregroundStyle(.white.opacity(0.3))
                        .multilineTextAlignment(.center)
                        .font(.custom_(.rootUI_Bold, size: 14))
                }
            }
            .navigationDestination(isPresented: $vm.showEnterCodeTenant) {
                InputTenantView()
            }
            .navigationDestination(isPresented: $vm.authIsCompleted) {
                Home()
            }
        }
    }
}
