#Preview { SplashView() }
import SwiftUI

struct TabsChangeLanguageInputCodetenant: View {
    
    @State private var vm = ViewModel()
            
    let leftIndicator = Rectangle()
    let rightIndicator = Rectangle()
    
    var body: some View {
        ZStack {
            Color.clear
            
            VStack {
                Button(action: {
                    vm.changeLanguage()
                    
                }, label: {
                    HStack {
                        Text("Рус")
                            .multilineTextAlignment(.center)
                            .frame(width: 60)
                            .frame(height: 48)
                            .foregroundColor(Color.white)
                            .font(.custom_(.rootUI_Regular, size: 18))

                        Text("En")
                            .multilineTextAlignment(.center)
                            .frame(width: 60)
                            .frame(height: 48)
                            .foregroundColor(Color.white)
                            .font(.custom_(.rootUI_Regular, size: 18))
                    }
                })
                
                HStack {
                    leftIndicator
                        .fill(.white)
                        .frame(width: 60, height: 3)
                        .opacity(vm.selectLanguage == .ru ? 1 : 0)
                    rightIndicator
                        .fill(.white)
                        .frame(width: 60, height: 3)
                        .opacity(vm.selectLanguage == .ru ? 0 : 1)
                }
            }
        }
        .frame(width: 120)
        .frame(height: 48)
    }
}


extension TabsChangeLanguageInputCodetenant {
    @Observable
    class ViewModel {
        
        var selectLanguage: Language = .ru
        
        func changeLanguage() {
            selectLanguage = selectLanguage == .en ? .ru : .en
        }
    }
}




