import Foundation

class SplashViewModel: ObservableObject {
    
    @Published var showEnterCodeTenant = false
    @Published var infoApp = ""
    @Published var goToGame = false
    
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
                DispatchQueue.main.async {
                    self.showEnterCodeTenant = true
                }
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
            await getGuides()
            await getGameCurrencies()
            await connectGlobalSocket()
            print("finish load getStartData")
            
            if LocalServices.localStorage._userData != nil {
                DispatchQueue.main.async {
                    self.goToGame = true
                }
            }
        }
    }
    
    /// получение  базовах цаетов
    /// полная настройка цветоаой схемы в AppTheme.createTheme
    private func getColorShemeTenant() async {
        DispatchQueue.main.async {
            self.infoApp = "Set color theme"
        }
        let json = await NetworkServices.shared.getColorShemeTenant()
//        print(json)
        if let json = json {
            AppTheme.createTheme(json: json)
        }
    }
    
    /// получение  словаря
    /// хранится в LocalServices.localStorage._languageDictionary в JSON
    private func getLanguageDictionary() async {
        DispatchQueue.main.async {
            self.infoApp = "Set dictionary"
        }
        let json = await NetworkServices.shared.getLanguageDictionary()
//        print(json)
        if let json = json {
            LocalServices.localStorage._languageDictionary = json
        }
    }
    
    /// получение  данных по пользователю
    /// хранится в LocalServices.localStorage._userData в JSON
    private func getUserData() async {
        DispatchQueue.main.async {
            self.infoApp = "Get user data"
        }
        let json = await NetworkServices.shared.getUserData()
        if let json = json {
            LocalServices.localStorage._userData = json
        }
    }
    
    private func getGuides() async {
        DispatchQueue.main.async {
            self.infoApp = "Get game guides"
        }
        let json = await NetworkServices.shared.getGuides()
        if let json = json {

        }
    }
    
    /// получение  всех валют тенанта
    /// хранится в LocalStorage.shared._currencie в [Currency]
    private func getGameCurrencies() async {
        DispatchQueue.main.async {
            self.infoApp = "Get game currencies"
        }
        let json = await NetworkServices.shared.getGameCurrencies()
        if let json = json {
            for i in json.arrayValue {
                let currency = Currency()
                await currency.parse(json: i)
                LocalStorage.shared._currencies?.append(currency)
            }
        }
    }
    
    private func connectGlobalSocket() async {
        DispatchQueue.main.async {
            self.infoApp = "Socket connect"
        }
        GlobalSocket.shared.connect()
    }
}
