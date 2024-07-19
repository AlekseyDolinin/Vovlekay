//#Preview { HomeView() }

import SwiftUI

struct HomeView: View {
    
    @StateObject var vm = HomeViewModel()
    @Binding var activateRootLink: Bool
    
    @State var navigated = false
    
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.BB_BGPrimary
                    .ignoresSafeArea()
                Button("logout") {
                    activateRootLink = false
                    vm.logout()
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading, content: {
                    Button {
                        print(1)
                        navigated = true
                    } label: {
                        Image("12")
                            .resizable()
                            .frame(width: 32, height: 32)
                            .cornerRadius(16)
                            .offset(x: 4)
                    }
                    .frame(width: 40, height: 40)
                    .background(.red)
                })
            }
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarBackground(.brown, for: .navigationBar)
            .navigationBarBackButtonHidden()
        }
        .navigationDestination(isPresented: $navigated) {
            AccountView()
        }
    }
}


class HomeViewModel: ObservableObject {
    
    func logout() {
        print("logout")
        LocalServices.clearLocalStorage()
    }
}
