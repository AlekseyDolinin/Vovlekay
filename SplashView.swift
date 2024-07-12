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
                    Text("\($vm.versionApp.wrappedValue)")
                        .foregroundStyle(.white.opacity(0.3))
                        .multilineTextAlignment(.center)
                        .font(.custom_(.rootUI_Bold, size: 14))
                }
            }
            .navigationDestination(isPresented: $vm.showEnterCodeTenant) {
                InputTenantView()
            }
            .onAppear {
                vm.getVersionApp()
            }
        }
    }
}


class ViewModelSplashView: ObservableObject {
    
    @Published var showEnterCodeTenant = false
    @Published var versionApp = ""
    
    func getVersionApp() {
        if let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] {
            self.versionApp = "\(version)"
        }
        //
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            // проверка авторизации
            if Auth.checkAuth() == false {
                self.showEnterCodeTenant = true
            } else {
                self.getStartData()
            }
        }
    }
    
    private func getStartData() {
        print("getStartData")
        Task(priority: .userInitiated) {
            await getColorShemeTenant()
            await getLanguageDictionary()
            await getUserData()
        }
        print("finish load getStartData")
    }
    
    private func getColorShemeTenant() async {
        print("getColorShemeTenant")
        let json = await NetworkServices.shared.getColorShemeTenant()
        print(json)
    }
    
    private func getLanguageDictionary() async {
//        let link = Endpoint.path(.getLanguageDictionary)
//        gDict = await API.shared._request(link, checkError: false) ?? JSON()
//        print("gDict: \(gDict)")
//        DictionaryCustom.setAppLanguage()
    }
    
    private func getUserData() async {
//        let link = Endpoint.path(.getUserData)
//        let json = await API.shared._request(link)
//        if let json = json {
//            if json["detail"].stringValue == "Учетные данные не были предоставлены." {
//                auth()
//            } else {
//                Parse.parsePlayer(json: json) { user in
//                    gCurrentUserData = user
//                    gCurrentUserData.state = .ready
//                    print("playerID: \(gCurrentUserData.id)")
//                    print("roles: \(gCurrentUserData.roles)")
//                }
//                DispatchQueue.main.async {
//                    GlobalSocket.shared.connect()
//                }
//            }
//        }
    }
    
}
