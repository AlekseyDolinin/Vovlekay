#Preview { HomeView() }

import SwiftUI

struct HomeView: View {
        
    @StateObject var vm = HomeViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.BB_RedUI
                    .ignoresSafeArea()
                    .navigationBarBackButtonHidden()

                Button("logout") {
                    vm.logout()
                }
            }
        }
    }
}


class HomeViewModel: ObservableObject {
    
    func logout() {
        print("logout")
        LocalServices.clearLocalStorage()
    }
}
