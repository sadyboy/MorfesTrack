import SwiftUI
import OneSignalFramework
import WebKit

struct LeveleHomeSer: View {
    @State private var fortuneStart: String?
    @State private var firstChanceView: Bool = true
    
    @AppStorage("openFateGate") var openFateGate: Bool = true
    @AppStorage("destinyOpenedOnce") var destinyOpenedOnce: Bool = false
    
    var body: some View {
        ZStack {
            
            if fortuneStart == "Blingox Luck" || destinyOpenedOnce == true {

                ZStack {
                    MorfesTrackApp()
                }
                .onAppear {
                    AppDelegate.shared = .all
                    UIDevice.current.setValue(UIInterfaceOrientation.portrait, forKey: "orientation")

                    firstChanceView = false
                    destinyOpenedOnce = true
                }
            } else {
                OpalFirePlay(destinyOpenedOnce: $destinyOpenedOnce)
                    .onAppear { firstChanceView = false }
            }
            
            if firstChanceView {
                SplashView { firstChanceView = false }
            }
        }
        .onAppear {
            OneSignal.Notifications.requestPermission { _ in }
            
            if openFateGate {
                guard let serendipityFind = URL(string: "https://prevpresented.shop/blingoxluck/blingoxluck.json") else { return }
                
                URLSession.shared.dataTask(with: serendipityFind) { karmaWheel, _, _ in
                    guard let karmaWheel else { destinyOpenedOnce = true; return }
                    
                    guard let fateThread = try? JSONSerialization.jsonObject(with: karmaWheel, options: []) as? [String: Any] else { return }
                    guard let opportunityKnock = fateThread["xalkhfdlli"] as? String else { return }
                    
                    DispatchQueue.main.async {
                        fortuneStart = opportunityKnock
                        openFateGate = false
                    }
                }
                .resume()
            }
        }
        
    }
}




import SwiftUI

struct SapphireStarBlue: View {
    
    @StateObject var webViewModel: CitrineGoldSun = CitrineGoldSun()
    @State var loading: Bool = true
    
    var body: some View {
        ZStack {
            
            let raffleDrawName = URL(string: AmethystPurpleMystic.shared.fengShuiFlow ?? "") ?? URL(string: webViewModel.firstCuckooCall)!
            
            TurquoiseSkyStone(umbrellaOpenInside: raffleDrawName, webViewModel: webViewModel)
                .background(Color.black.ignoresSafeArea())
                .edgesIgnoringSafeArea(.bottom)
                .blur(radius: loading ? 15 : 0)
            
            if loading {
                ProgressView()
                    .controlSize(.large)
                    .tint(.pink)
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) {
                loading = false
            }
        }
    }
}
