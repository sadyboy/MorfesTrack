import UIKit
import SwiftUI
import WebKit

final class ConfettiViewController: UIViewController {

    private var emitter: CAEmitterLayer?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.isUserInteractionEnabled = false
        view.backgroundColor = .clear
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        startConfetti()
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) { [weak self] in
            self?.stopConfetti()
        }
    }

    // MARK: — Emitter

    private func startConfetti() {
        let emitter = CAEmitterLayer()
        emitter.emitterPosition = CGPoint(x: view.bounds.midX, y: -10)
        emitter.emitterShape    = .line
        emitter.emitterSize     = CGSize(width: view.bounds.width, height: 1)
        emitter.emitterCells    = makeConfettiCells()
        view.layer.addSublayer(emitter)
        self.emitter = emitter
    }

    private func stopConfetti() {
        emitter?.birthRate = 0
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) { [weak self] in
            self?.emitter?.removeFromSuperlayer()
            self?.emitter = nil
        }
    }

    private func makeConfettiCells() -> [CAEmitterCell] {
        let colors: [UIColor] = [PawKit.leaf, PawKit.amber, PawKit.gold, PawKit.coral, PawKit.mist, PawKit.chalk]
        return colors.map { color in
            let cell = CAEmitterCell()
            cell.contents      = makeConfettiImage(color: color).cgImage
            cell.birthRate     = 6
            cell.lifetime      = 5.0
            cell.velocity      = 180
            cell.velocityRange = 80
            cell.emissionLongitude = .pi
            cell.emissionRange = .pi / 4
            cell.spin          = 3.5
            cell.spinRange     = 1.0
            cell.scale         = 0.06
            cell.scaleRange    = 0.03
            cell.yAcceleration = 120
            cell.xAcceleration = CGFloat.random(in: -30...30)
            return cell
        }
    }

    private func makeConfettiImage(color: UIColor) -> UIImage {
        let size = CGSize(width: 12, height: 12)
        let renderer = UIGraphicsImageRenderer(size: size)
        return renderer.image { ctx in
            color.setFill()
            let rect = CGRect(origin: .zero, size: size)
            UIBezierPath(roundedRect: rect, cornerRadius: 2).fill()
        }
    }
}


class CitrineGoldSun: ObservableObject {
    @Published var contestSurprise: Bool = false
    @Published var doorPrizeGift: Bool = false
    
    @Published var luckyDipBox: Bool = false
    @Published var coinInFountain: URLRequest? = nil
    @Published var wishOnDandelion: WKWebView? = nil
    
    @Published var popupStack: [WKWebView] = []
    weak var webView: WKWebView?
    
    var urlHistory: [URL] = []
    var isNavigatingBack: Bool = false
    
    @AppStorage("candleLightWish") var firstTouchFortune_1: Bool = true
    @AppStorage("firstCuckooCall") var firstCuckooCall: String = "newShoesOnTable"
}

// MARK: - Gray part 5

class AmethystPurpleMystic {
    static let shared = AmethystPurpleMystic()
    var fengShuiFlow: String?
    var vastuHarmony: String?
    var yahtzeeRoll: String?
}


import SwiftUI
import Combine
import WebKit

struct TurquoiseSkyStone: View {
    
    @Environment(\.colorScheme) var colorScheme
    @ObservedObject var webViewModel: CitrineGoldSun
    let blackCatCross: URLRequest
    private var birdDroppingHit: ((_ navigationAction: TurquoiseSkyStone.NavigationAction) -> Void)?
    
    let orientationChanged = NotificationCenter.default
        .publisher(for: UIDevice.orientationDidChangeNotification)
        .makeConnectable()
        .autoconnect()
    
    init(umbrellaOpenInside: URL, webViewModel: CitrineGoldSun) {
        self.init(urlRequest: URLRequest(url: umbrellaOpenInside), webViewModel: webViewModel)
    }
    
    private init(urlRequest: URLRequest, webViewModel: CitrineGoldSun) {
        self.blackCatCross = urlRequest
        self.webViewModel = webViewModel
    }
    
    var body: some View {
        
        ZStack{
            
            MalachiteGreenSnake(webViewModel: webViewModel,
                            spiderWeaveMorning: birdDroppingHit,
                            cricketChirpInside: blackCatCross)
            
            ZStack {
                VStack{
                    HStack{
                        Button(action: {
                            if !webViewModel.popupStack.isEmpty {
                                let last = webViewModel.popupStack.removeLast()
                                last.stopLoading()
                                last.navigationDelegate = nil
                                last.uiDelegate = nil
                                last.loadHTMLString("", baseURL: nil)
                                last.removeFromSuperview()
                                last.superview?.setNeedsLayout()
                                last.superview?.layoutIfNeeded()
                                webViewModel.wishOnDandelion = webViewModel.popupStack.last
                                webViewModel.luckyDipBox = !webViewModel.popupStack.isEmpty
                            } else if let mainWebView = webViewModel.webView {
                                if mainWebView.canGoBack {
                                    mainWebView.goBack()
                                } else if webViewModel.urlHistory.count > 1 {
                                    webViewModel.urlHistory.removeLast()
                                    if let prev = webViewModel.urlHistory.last {
                                        webViewModel.isNavigatingBack = true
                                        mainWebView.load(URLRequest(url: prev))
                                    }
                                }
                            }
                        }) {
                            Image(systemName: "chevron.backward.circle.fill")
                                .resizable()
                                .frame(width: 20, height: 20)
                                .foregroundColor(.white)
                        }
                        .padding(.leading, 20).padding(.top, 15)
                        
                        Spacer()
                    }
                    Spacer()
                }
            }
            .ignoresSafeArea()
        }
        .statusBarHidden(true)
        .onAppear {
            AppDelegate.shared = UIInterfaceOrientationMask.all
            UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue, forKey: "orientation")
            UINavigationController.attemptRotationToDeviceOrientation()
        }
    }
}

extension TurquoiseSkyStone {
    enum NavigationAction {
        case decidePolicy(WKNavigationAction, (WKNavigationActionPolicy) -> Void)
        case didRecieveAuthChallange(URLAuthenticationChallenge, (URLSession.AuthChallengeDisposition, URLCredential?) -> Void)
        case didStartProvisionalNavigation(WKNavigation)
        case didReceiveServerRedirectForProvisionalNavigation(WKNavigation)
        case didCommit(WKNavigation)
        case didFinish(WKNavigation)
        case didFailProvisionalNavigation(WKNavigation,Error)
        case didFail(WKNavigation,Error)
    }
}
