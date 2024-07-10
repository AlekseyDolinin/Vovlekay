#Preview { SplashView() }

import SwiftUI
import WebKit
import UIKit

struct WebViewAuth: UIViewControllerRepresentable {

    typealias UIViewControllerType = AuthWebVC
    
    func makeUIViewController(context: Context) -> AuthWebVC {
        let vc = AuthWebVC()
        return vc
    }

    func updateUIViewController(_ uiViewController: AuthWebVC, context: Context) {
        
    }
}



import UIKit
import WebKit
import MessageUI

class AuthWebVC: UIViewController {
        
    var basicWebView: WKWebView!
    var webViewURLObserver: NSKeyValueObservation?
    
//    private let changeTenantButton = ButtonFirst()
    
    var linkAuth = Endpoint.path(.linkAuth)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let webConfiguration = WKWebViewConfiguration()
        webConfiguration.preferences.javaScriptCanOpenWindowsAutomatically = true
        webConfiguration.applicationNameForUserAgent = "Version/8.0.2 Safari/600.2.5"
        basicWebView = WKWebView(frame: .zero, configuration: webConfiguration)
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
                self.basicWebView.alpha = 0
                LocalStorage.Cookies.saveCookie(webView: self.basicWebView)
            }
        }
        //
//        navigationController?.navigationBar.isHidden = true
//        tabBarController?.tabBar.isHidden = true
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
//        basicWebView.scrollView.backgroundColor = .BB_BGPrimary
        basicWebView.contentMode = .scaleAspectFill
        //
        basicWebView.translatesAutoresizingMaskIntoConstraints = false
        basicWebView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        basicWebView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        basicWebView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        basicWebView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
    }
    
//    private func saveCookie() {
//        self.basicWebView.configuration.websiteDataStore.httpCookieStore.getAllCookies { cookies in
//            for cookie in cookies {
//                if cookie.name == "user_id" && cookie.domain == Config.hostname {
//                    var cookieDict = [String : AnyObject]()
//                    cookieDict[cookie.name] = cookie.properties as AnyObject?
//                    // save cookies
//                    UserDefaults.standard.set(cookieDict, forKey: .cookiesKey)
//                    print("saveCookie")
//                    appDelegate.loadDataForStart()
//                }
//            }
//        }
//    }
    
//    private func createChangeTenantButton() {
//        view.addSubview(changeTenantButton)
//        changeTenantButton.setTitle("Ввести другой код компании", for: .normal)
//        changeTenantButton.addTarget(self, action: #selector(changeTenantAction), for: .touchUpInside)
//        //
//        changeTenantButton.translatesAutoresizingMaskIntoConstraints = false
//        changeTenantButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -24).isActive = true
//        changeTenantButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 12).isActive = true
//        changeTenantButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -12).isActive = true
//        changeTenantButton.heightAnchor.constraint(equalToConstant: 48).isActive = true
//    }
    
//    @objc private func changeTenantAction() {
//        print("changeTenantAction")
//        showLoader()
//        Logout().logout()
//    }
}


extension AuthWebVC: UIWebViewDelegate, WKNavigationDelegate, WKUIDelegate {
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
//        showLoader()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
//        hideLoader()
//        createChangeTenantButton()
    }
    
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
