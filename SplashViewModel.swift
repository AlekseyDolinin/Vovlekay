import Foundation

class SplashViewModel: ObservableObject {
    
    @Published var showEnterCodeTenant = false
    @Published var infoApp = ""
    @Published var showHomeView = false
    
    init() {
        NotificationCenter.default.addObserver(self, 
                                               selector: #selector(self.getStartDataAfterAuth),
                                               name: Notification.Name("authIsSucces"),
                                               object: nil)
    }
    
    @objc func getStartDataAfterAuth() {
        DispatchQueue.main.async {
            self.showEnterCodeTenant = false
            self.getStartData()
        }
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.getStartData()
//        }
    }
    
    func getVersionApp() {
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
            print(AppTheme.colors != nil)
            print(LocalServices.localStorage._languageDictionary != nil)
            print(LocalServices.localStorage._userData != nil)
            
            if AppTheme.colors != nil
                && LocalServices.localStorage._languageDictionary != nil
                && LocalServices.localStorage._userData != nil {
                DispatchQueue.main.async {
                    self.showHomeView = true
                }
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
        if let json = json {
            LocalServices.localStorage._languageDictionary = json
        }
    }
    
    private func getUserData() async {
        DispatchQueue.main.async {
            self.infoApp = "Get user data"
        }
        let json = await NetworkServices.shared.getUserData()
        if let json = json {
            LocalServices.localStorage._userData = json
        }
    }
    
}
