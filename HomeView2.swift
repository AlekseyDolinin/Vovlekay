#Preview { HomeView2() }

import SwiftUI

struct HomeView2: View {
        
    @StateObject var vm = HomeView2Model()
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.yellow
                    .ignoresSafeArea()
                    .navigationBarBackButtonHidden()
                Button("------") {
                    vm.logout()
                }
            }
        }
    }
}


class HomeView2Model: ObservableObject {
    
    func logout() {
        print("logout")
        LocalServices.clearLocalStorage()
    }
}
