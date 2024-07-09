#Preview { InputTenantView() }

import SwiftUI

struct InputTenantView: View {
    
    @State var vm = ViewModel()
    @State private var showingAlert = false
    @StateObject private var ns = NetworkServices()

    private let widthScreen = UIScreen.main.bounds.width
    
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
                    Text(textInputCode)
                        .foregroundStyle(.white)
                        .multilineTextAlignment(.center)
                        .font(.custom_(.rootUI_Bold, size: 18))
                    Spacer(minLength: 16)
                    TextField("", text: $vm.codeTenant, prompt: Text(textCode).foregroundColor(.gray))
                        .foregroundStyle(.white)
                        .multilineTextAlignment(.center)
                        .padding(.top, 24)
                        .padding(.bottom, 24)
                        .frame(width: widthScreen - 48)
                        .background(.gray.opacity(0.1))
                        .cornerRadius(8)
                        .font(.custom_(.rootUI_Regular, size: 18))
                        .autocorrectionDisabled()
                    
                    Spacer(minLength: 48)
                    Button {
                        showingAlert = vm.codeTenant.isEmpty
                        vm.sendCode()
                        
//                        print("json_2: \($ns.json.wrappedValue)")
//                        print("count: \($ns.count.wrappedValue)")

                    } label: {
                        Text(textSend)
                            .foregroundStyle(.black)
                            .font(.custom_(.rootUI_Medium, size: 18))
                            .frame(height: 48)
                            .frame(width: widthScreen - 48)
                            .background(Color._yellow.opacity(vm.codeTenant.isEmpty ? 0.2 : 1.0))
                            .cornerRadius(8)
                    }
                    .alert(textCodeInputIsEmpty, isPresented: $showingAlert) {
                        Button("OK", role: .cancel) { }
                    }
//                    .alert("1212", isPresented: $ns) {
//                        if $ns.json != nil {
//                            print(12)
//                        }
//                    }
                    
                    Spacer(minLength: 48)
                    Text(textComment)
                        .foregroundStyle(.white.opacity(0.5))
                        .multilineTextAlignment(.center)
                        .font(.custom_(.rootUI_Regular, size: 16))
                        .padding(.leading, 24)
                        .padding(.trailing, 24)
                        .frame(height: 56)
                    Spacer(minLength: 48)
                    ZStack {
                        Color.clear
                        VStack {
                            HStack {
                                VStack {
                                    Button(action: {
                                        vm.changeLanguage(language: .ru)
                                    }, label: {
                                        Text("Рус")
                                            .multilineTextAlignment(.center)
                                            .frame(width: 60)
                                            .frame(height: 48)
                                            .foregroundColor(Color.white)
                                            .font(.custom_(.rootUI_Regular, size: 18))
                                    })
                                    Rectangle()
                                        .fill(.white)
                                        .frame(width: 60, height: 3)
                                        .opacity(vm.language == .ru ? 1 : 0)
                                }
                                VStack {
                                    Button(action: {
                                        vm.changeLanguage(language: .en)
                                    }, label: {
                                        Text("En")
                                            .multilineTextAlignment(.center)
                                            .frame(width: 60)
                                            .frame(height: 48)
                                            .foregroundColor(Color.white)
                                            .font(.custom_(.rootUI_Regular, size: 18))
                                    })
                                    Rectangle()
                                        .fill(.white)
                                        .frame(width: 60, height: 3)
                                        .opacity(vm.language == .en ? 1 : 0)
                                }
                                VStack {
                                    Button(action: {
                                        vm.changeLanguage(language: .kz)
                                    }, label: {
                                        Text("Kz")
                                            .multilineTextAlignment(.center)
                                            .frame(width: 60)
                                            .frame(height: 48)
                                            .foregroundColor(Color.white)
                                            .font(.custom_(.rootUI_Regular, size: 18))
                                    })
                                    Rectangle()
                                        .fill(.white)
                                        .frame(width: 60, height: 3)
                                        .opacity(vm.language == .kz ? 1 : 0)
                                }
                            }
                        }
                    }
                    .frame(width: 120)
                    .frame(height: 48)
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
        var language: AppLanguage.Language = .ru
        
        func changeLanguage(language: AppLanguage.Language) {
            self.language = AppLanguage.changeLanguage(language: language)
        }
        
        func sendCode() {
            if !codeTenant.isEmpty {
                NetworkServices.shared.sendCodeTenant(codeTenant: codeTenant.replacingOccurrences(of: " ", with: ""))
                
            }
        }
    }
}


extension InputTenantView {
    
    var textInputCode: String {
        switch vm.language {
        case .ru:
            return "Введите код компании"
        case .en:
            return "Enter company code"
        case .kz:
            return "Компания кодын енгізіңіз"
        }
    }
    
    var textCode: String {
        switch vm.language {
        case .ru:
            return "Код"
        case .en:
            return "Code"
        case .kz:
            return "Код"
        }
    }
    
    var textSend: String {
        switch vm.language {
        case .ru:
            return "Отправить"
        case .en:
            return "Send"
        case .kz:
            return "Жіберу"
        }
    }
    
    var textComment: String {
        switch vm.language {
        case .ru:
            return "Для работы приложения требуется подключение к сети интернет"
        case .en:
            return "App requires internet connection"
        case .kz:
            return "Қолданба жұмыс істеуі үшін интернет байланысы қажет."
        }
    }
    
    var textCodeInputIsEmpty: String {
        switch vm.language {
        case .ru:
            return "Необходимо ввести код компании"
        case .en:
            return "You must enter the company code"
        case .kz:
            return "Сіз компания кодын енгізуіңіз керек"
        }
    }
}
