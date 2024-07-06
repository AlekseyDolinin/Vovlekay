#Preview { InputTenantView() }

import SwiftUI

struct InputTenantView: View {
    
    @State private var vm = ViewModel()
    
    let widthScreen = UIScreen.main.bounds.width
        
    init() {
    }
    
    var body: some View {
        
        NavigationStack {
            ZStack {
                Color.black
                    .ignoresSafeArea()
                
                VStack {
                    
                    Spacer(minLength: 100)
                    
                    Image("logo_frame")
                        .renderingMode(.template)
                        .foregroundColor(._yellow)
                        .aspectRatio(contentMode: .fill)
                        .frame(width: widthScreen / 4)
                        .frame(height: widthScreen / 4)
                        .frame(alignment: .center)
                    
                    Spacer(minLength: 32)
                    
                    Text("Введите код компании")
                        .foregroundStyle(.white)
                        .multilineTextAlignment(.center)
                        .font(.custom_(.rootUI_Bold, size: 18))
                    
                    Spacer(minLength: 16)
                    
                    TextField("Код", text: $vm.codeTenant, prompt: Text("Код").foregroundColor(.gray))
                        .foregroundStyle(.white)
                        .multilineTextAlignment(.center)
                        .padding(.top, 24)
                        .padding(.bottom, 24)
                        .frame(width: widthScreen - 48)
                        .background(.gray.opacity(0.1))
                        .cornerRadius(8)
                        .font(.custom_(.rootUI_Regular, size: 18))
                    
                    Spacer(minLength: 48)
                    
                    Button {
                        print(12)
                    } label: {
                        Text("Отправить")
                            .foregroundStyle(.black)
                            .font(.custom_(.rootUI_Medium, size: 18))
                    }
                    .frame(height: 48)
                    .frame(width: widthScreen - 48)
                    .background(Color._yellow)
                    .cornerRadius(8)
                    
                    Spacer(minLength: 48)
                    
                    Text("Для работы приложения требуется подключение к сети интернет")
                        .foregroundStyle(.white.opacity(0.5))
                        .multilineTextAlignment(.center)
                        .font(.custom_(.rootUI_Regular, size: 16))
                        .padding(.leading, 24)
                        .padding(.trailing, 24)
                        .fixedSize(horizontal: false, vertical: true)
                    
                    Spacer(minLength: 48)
                    
                    TabsChangeLanguageInputCodetenant()
                    
                    Spacer(minLength: 200)
                }
            }
        }
    }
}


extension InputTenantView {
    @Observable
    class ViewModel {
        
        var codeTenant: String = ""
        
    }
}
