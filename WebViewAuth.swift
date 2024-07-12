#Preview { SplashView() }

import SwiftUI
import WebKit
import UIKit
import MessageUI

struct WebViewAuth: UIViewControllerRepresentable {

    var authIsSucces: Binding<Bool>
    
    func makeUIViewController(context: Context) -> AuthWebVC {
        let vc = AuthWebVC()
        vc.delegate = context.coordinator
        return vc
    }

    func updateUIViewController(_ uiViewController: AuthWebVC, context: Context) { }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(authIsSucces: authIsSucces)
    }
}


class Coordinator: AuthWebVCDelegate {

    let authIsSucces: Binding<Bool>
    
    init(authIsSucces: Binding<Bool>) {
        self.authIsSucces = authIsSucces
    }
    
    func authIsSucces(_ result: Bool) {
        authIsSucces.wrappedValue = result
    }
}


protocol AuthWebVCDelegate: AnyObject {
    func authIsSucces(_ result: Bool)
}

class AuthWebVC: UIViewController, ObservableObject {
                
    weak var delegate: AuthWebVCDelegate?
    
    var authIsSucces = false
    
    var basicWebView: WKWebView!
    var webViewURLObserver: NSKeyValueObservation?
    var linkAuth = Endpoint.path(.linkAuth)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let webConfiguration = WKWebViewConfiguration()
        webConfiguration.preferences.javaScriptCanOpenWindowsAutomatically = true
        webConfiguration.applicationNameForUserAgent = "Version/8.0.2 Safari/600.2.5"
        basicWebView = WKWebView(frame: .zero, configuration: webConfiguration)
        basicWebView.cleanAllCookies()
        basicWebView.uiDelegate = self
        createWebView()
        //
        guard let url = URL(string: linkAuth) else { return }
        let urlRequest = URLRequest(url: url)
        basicWebView.load(urlRequest)
        //
        webViewURLObserver = basicWebView.observe(\.url, options: .new) { webView, change in
            guard let newValueUrl = change.newValue else { return }
            if newValueUrl?.lastPathComponent == "home" {
                LocalStorage.Cookies.saveCookie(webView: self.basicWebView)
                self.dismiss(animated: true) {
                    self.delegate?.authIsSucces(true)
                }
            }
        }
    }
    
    deinit { print("deinit AuthWebVC") }
    
    func createWebView() {
        view.addSubview(basicWebView)
        basicWebView.navigationDelegate = self
        basicWebView.uiDelegate = self
        basicWebView.allowsBackForwardNavigationGestures = true
        basicWebView.clearsContextBeforeDrawing = true
        basicWebView.scrollView.showsVerticalScrollIndicator = false
        basicWebView.scrollView.showsHorizontalScrollIndicator = false
        basicWebView.scrollView.backgroundColor = .black
        basicWebView.contentMode = .scaleAspectFill
        //
        basicWebView.translatesAutoresizingMaskIntoConstraints = false
        basicWebView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        basicWebView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        basicWebView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        basicWebView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
    }
}


extension AuthWebVC: UIWebViewDelegate, WKNavigationDelegate, WKUIDelegate {
    
    func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
        guard let temp = navigationAction.request.mainDocumentURL?.absoluteString else { return nil }
        if temp.prefix(6) == "mailto" {
            createMail()
        } else {
            if navigationAction.targetFrame == nil {
                webView.load(navigationAction.request)
            }
        }
        return nil
    }
}


extension AuthWebVC: MFMailComposeViewControllerDelegate {
    
    @objc func createMail() {
        if !MFMailComposeViewController.canSendMail() {
            print("Mail services are not available")
            return
        } else {
            let mailAdminTenant: String = "support@labmedia.su"
            let composeVC = MFMailComposeViewController()
            composeVC.mailComposeDelegate = self
            composeVC.setToRecipients([mailAdminTenant])
            self.present(composeVC, animated: true)
        }
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
}




extension WKWebView {

    func cleanAllCookies() {
        HTTPCookieStorage.shared.removeCookies(since: Date.distantPast)
        print("All cookies deleted")

        WKWebsiteDataStore.default().fetchDataRecords(ofTypes: WKWebsiteDataStore.allWebsiteDataTypes()) { records in
            records.forEach { record in
                WKWebsiteDataStore.default().removeData(ofTypes: record.dataTypes, for: [record], completionHandler: {})
                print("Cookie ::: \(record) deleted")
            }
        }
    }

    func refreshCookies() {
        self.configuration.processPool = WKProcessPool()
    }
}
