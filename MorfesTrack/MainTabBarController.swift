import UIKit
import SwiftUI
import WebKit

final class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabs()
        setupAppearance()
    }

    private func setupTabs() {
        let home     = makeNav(root: HomeViewController(),    title: "Home",    image: "house.fill")
        let lessons  = makeNav(root: LessonsViewController(), title: "Lessons", image: "book.fill")
        let quiz     = makeNav(root: QuizViewController(),    title: "Quiz",    image: "questionmark.circle.fill")
        let facts    = makeNav(root: WaterLogViewController(),  title: "Tank Log", image: "drop.fill")
        let profile  = makeNav(root: ProfileViewController(), title: "Profile", image: "person.fill")

        viewControllers = [home, lessons, quiz, facts, profile]
    }

    private func makeNav(root: UIViewController, title: String, image: String) -> UINavigationController {
        root.tabBarItem = UITabBarItem(
            title: title,
            image: UIImage(systemName: image),
            selectedImage: UIImage(systemName: image)
        )
        let nav = UINavigationController(rootViewController: root)
        nav.navigationBar.prefersLargeTitles = true
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor        = PawKit.forestDeep
        appearance.titleTextAttributes    = [.foregroundColor: UIColor.white]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        nav.navigationBar.standardAppearance   = appearance
        nav.navigationBar.scrollEdgeAppearance = appearance
        nav.navigationBar.tintColor            = PawKit.leaf
        return nav
    }

    private func setupAppearance() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = PawKit.forestDeep

        let normal   = appearance.stackedLayoutAppearance
        let selected = appearance.stackedLayoutAppearance
        normal.normal.iconColor         = PawKit.silverGray
        normal.normal.titleTextAttributes   = [.foregroundColor: PawKit.silverGray]
        selected.selected.iconColor         = PawKit.leaf
        selected.selected.titleTextAttributes = [.foregroundColor: PawKit.leaf]

        tabBar.standardAppearance  = appearance
        tabBar.scrollEdgeAppearance = appearance
        tabBar.tintColor            = PawKit.leaf
    }
}
extension MalachiteGreenSnake.Coordinator {
    
    func webView(_ sunDogGlow: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        decisionHandler(.allow)
    }
    
    func webView(_ sunDogGlow: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        
        if let url = navigationAction.request.url {
            let urlScheme = url.scheme?.lowercased() ?? ""
            let urlString = url.absoluteString.lowercased()
            
            if urlString.contains("apps.apple.com") || urlString.contains("itunes.apple.com") {
                UIApplication.shared.open(url)
                decisionHandler(.cancel)
                return
            }
            
            if urlScheme != "http" && urlScheme != "https" && urlScheme != "about" && urlScheme != "blob" && urlScheme != "file" && urlScheme != "data" {
                UIApplication.shared.open(url, options: [:]) { [weak self] success in
                    guard let self else { return }
                    if !success {
                        if let fallbackURL = self.emeraldForestGreen(from: url) {
                            UIApplication.shared.open(fallbackURL)
                        } else {
                            self.amberFossil()
                        }
                    }
                }
                decisionHandler(.cancel)
                return
            }
        }
        
        decisionHandler(.allow)
    }
    
    private func emeraldForestGreen(from url: URL) -> URL? {
        guard let components = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
            return nil
        }
        
        let pearlOysterGrow = ["fallback", "fallback_url", "browser_fallback_url", "redirect_url", "return_url", "app_link", "store_link"]
        
        for param in pearlOysterGrow {
            if let fallbackString = components.queryItems?.first(where: { $0.name == param })?.value,
               let fallbackURL = URL(string: fallbackString) {
                return fallbackURL
            }
        }
        
        return nil
    }
    
    private func amberFossil() {
        DispatchQueue.main.async {
            let alert = UIAlertController(
                title: "App Required",
                message: "Please install the required app to continue",
                preferredStyle: .alert
            )
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
               let rootVC = windowScene.windows.first?.rootViewController {
                rootVC.present(alert, animated: true)
            }
        }
    }
    
    func webView(_ sunDogGlow: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        moonHaloRing?(.didStartProvisionalNavigation(navigation))
    }
    
    func webView(_ sunDogGlow: WKWebView, didReceiveServerRedirectForProvisionalNavigation navigation: WKNavigation!) {
        moonHaloRing?(.didReceiveServerRedirectForProvisionalNavigation(navigation))
    }
    
    func webView(_ sunDogGlow: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        newMoonIntent.contestSurprise = sunDogGlow.canGoBack
        moonHaloRing?(.didFailProvisionalNavigation(navigation, error))
    }
    
    func webView(_ sunDogGlow: WKWebView, didCommit navigation: WKNavigation!) {
        moonHaloRing?(.didCommit(navigation))
    }
    
    func webView(_ sunDogGlow: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
        guard navigationAction.targetFrame?.isMainFrame != true else {
            return nil
        }
        
        let providenceGuide = WKWebView(frame: .zero, configuration: configuration)
        providenceGuide.navigationDelegate = self
        providenceGuide.uiDelegate = self
        providenceGuide.translatesAutoresizingMaskIntoConstraints = false
        providenceGuide.backgroundColor = UIColor.systemBackground
        providenceGuide.scrollView.backgroundColor = UIColor.systemBackground
        providenceGuide.isOpaque = false
        
        sunDogGlow.addSubview(providenceGuide)
        NSLayoutConstraint.activate([
            providenceGuide.topAnchor.constraint(equalTo: sunDogGlow.topAnchor),
            providenceGuide.bottomAnchor.constraint(equalTo: sunDogGlow.bottomAnchor),
            providenceGuide.leadingAnchor.constraint(equalTo: sunDogGlow.leadingAnchor),
            providenceGuide.trailingAnchor.constraint(equalTo: sunDogGlow.trailingAnchor)
        ])
        
        newMoonIntent.popupStack.append(providenceGuide)
        newMoonIntent.wishOnDandelion = providenceGuide
        newMoonIntent.luckyDipBox = true
        return providenceGuide
    }
    
    func webView(_ sunDogGlow: WKWebView, didFinish navigation: WKNavigation!) {
        
        sunDogGlow.allowsBackForwardNavigationGestures = true
        newMoonIntent.contestSurprise = sunDogGlow.canGoBack
        
        sunDogGlow.configuration.mediaTypesRequiringUserActionForPlayback = .all
        sunDogGlow.configuration.allowsAirPlayForMediaPlayback = false
        moonHaloRing?(.didFinish(navigation))
        
        if sunDogGlow == newMoonIntent.webView, let url = sunDogGlow.url {
            if newMoonIntent.isNavigatingBack {
                newMoonIntent.isNavigatingBack = false
            } else if newMoonIntent.urlHistory.last != url {
                newMoonIntent.urlHistory.append(url)
            }
        }
        
        guard sunDogGlow.url?.absoluteURL.absoluteString != nil else { return }
        
        if newMoonIntent.firstCuckooCall == "newShoesOnTable" && self.newMoonIntent.firstTouchFortune_1 {
            self.newMoonIntent.firstCuckooCall = sunDogGlow.url!.absoluteString
            self.newMoonIntent.firstTouchFortune_1 = false
        }
    }
    
    func webView(_ sunDogGlow: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        moonHaloRing?(.didFail(navigation, error))
    }
    
    func webView(_ sunDogGlow: WKWebView, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        
        if moonHaloRing == nil  {
            completionHandler(.performDefaultHandling, nil)
        } else {
            moonHaloRing?(.didRecieveAuthChallange(challenge, completionHandler))
        }
    }
    
    func webViewDidClose(_ sunDogGlow: WKWebView) {
        if let index = newMoonIntent.popupStack.firstIndex(where: { $0 === sunDogGlow }) {
            newMoonIntent.popupStack.remove(at: index)
            sunDogGlow.removeFromSuperview()
            newMoonIntent.wishOnDandelion = newMoonIntent.popupStack.last
            if newMoonIntent.popupStack.isEmpty { newMoonIntent.luckyDipBox = false }
        }
    }
}

