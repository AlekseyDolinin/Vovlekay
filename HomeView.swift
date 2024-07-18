//#Preview { HomeView() }

import SwiftUI

struct HomeView: View {
    
    @StateObject var vm = HomeViewModel()
    @Binding var activateRootLink: Bool
    
    var body: some View {
        NavigationStack {
            NavigationViewBB(content: ZStack {
                Color.BB_BGPrimary
                    .ignoresSafeArea()
                Button("logout") {
                    activateRootLink = false
                    vm.logout()
                }
            })
        }
    }
}


class HomeViewModel: ObservableObject {
    
    func logout() {
        print("logout")
        LocalServices.clearLocalStorage()
    }
}




struct NavigationViewBB<Content>: View where Content: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    let content: Content
    
    var body: some View {
        NavigationView {
            VStack {
                NavBarBB(backHandler: {
                    self.presentationMode.wrappedValue.dismiss()
                })
                content
            }
        }
        .navigationBarHidden(true)
    }
}



struct NavBarBB: View {
    
    let backHandler: (() -> Void)

    var body: some View {
        VStack {
            Spacer()
            HStack {
                Button(action: { self.backHandler() }) {
                    Image("12")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 40, height: 40)
                        .cornerRadius(20)
                }
                Spacer()
                Button(action: { self.backHandler() }) {
                    Image(systemName: "magnifyingglass")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 24, height: 24)
                        .foregroundColor(Color.BB_TextHigh)
                }
                .frame(width: 40, height: 40)
                Button(action: { self.backHandler() }) {
                    Image(systemName: "line.3.horizontal")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 24, height: 24)
                        .foregroundColor(Color.BB_TextHigh)
                }
                .frame(width: 40, height: 40)
            }
            .padding([.leading, .trailing], 12)
            Spacer()
        }
        .background(Color.BB_BGPrimary.opacity(0.9).edgesIgnoringSafeArea(.all))
        .frame(height: 40)
    }
}
