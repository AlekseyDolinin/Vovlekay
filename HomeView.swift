#Preview { HomeView() }

import SwiftUI

struct HomeView: View {
    
    @StateObject var vm = HomeViewModel()
    
    var body: some View {
        NavigationStack {
            NavigationViewBB(content: ZStack {
                Color.BB_BGPrimary
                    .ignoresSafeArea()
                Button("logout") {
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
                }, title: "")
                content
            }
        }
        .navigationBarTitle("")
        .navigationBarHidden(true)
    }
}



struct NavBarBB: View {
    let backHandler: (() -> Void)
    let title: String
        
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Button(action: { self.backHandler() }) {
                    Image("12")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                }
                .frame(width: 40)
                .frame(height: 40)
                .cornerRadius(20)
                .background(.red)
                Spacer()
                HStack {
                    Button(action: { self.backHandler() }) {
                        Image(systemName: "magnifyingglass")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 24)
                            .frame(height: 24)
                            .foregroundColor(Color.BB_TextHigh)
                    }
                    .frame(width: 40)
                    .frame(height: 40)
                    Button(action: { self.backHandler() }) {
                        Image(systemName: "line.3.horizontal")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 24)
                            .frame(height: 24)
                            .foregroundColor(Color.BB_TextHigh)
                    }
                    .frame(width: 40)
                    .frame(height: 40)
                }
            }
            .padding([.leading, .trailing], 12)
            Spacer()
        }
        .background(Color.purple.edgesIgnoringSafeArea(.all))
//        .background(Color.BB_BGPrimary.edgesIgnoringSafeArea(.all))
        .frame(height: 40)
    }
}
