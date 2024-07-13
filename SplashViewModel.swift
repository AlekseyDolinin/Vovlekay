import Foundation

class SplashViewModel: ObservableObject {
    
    @Published var showEnterCodeTenant = false
    @Published var authIsCompleted = false
    @Published var infoApp = ""
    
    func getVersionApp() {
        
//        LocalServices.clearLocalStorage()
        
        if let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] {
            DispatchQueue.main.async {
                self.infoApp = "\(version)"
            }
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
            print("finish load getStartData")
            DispatchQueue.main.async {
                self.authIsCompleted = true
            }
        }
    }
    
    private func getColorShemeTenant() async {
        DispatchQueue.main.async {
            self.infoApp = "Set color theme"
        }
        let json = await NetworkServices.shared.getColorShemeTenant()
        if let json = json {
            AppTheme.createTheme(json: json)
        }
    }
    
    private func getLanguageDictionary() async {
        DispatchQueue.main.async {
            self.infoApp = "Set dictionary"
        }
        let json = await NetworkServices.shared.getLanguageDictionary()
    }
    
    private func getUserData() async {
        print("getUserData")
        DispatchQueue.main.async {
            self.infoApp = "Get user data"
        }
        let json = await NetworkServices.shared.getUserData()
        print("json: \(json)")

    }
    
}
