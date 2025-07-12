import Foundation
import WatchConnectivity
import SwiftUI

class ConnectivityManager: NSObject, ObservableObject, WCSessionDelegate {
    @Published var watchConnected = false
    @Published var isSeizureOngoing = false
    @Published var isMonitoringOnWatch = false

    var historyManager: HistoryManager?

    override init() {
        super.init()
        if WCSession.isSupported() {
            let session = WCSession.default
            session.delegate = self
            session.activate()
        }
    }

    func session(_ session: WCSession, activationDidCompleteWith state: WCSessionActivationState, error: Error?) {
        watchConnected = session.isPaired && session.isWatchAppInstalled
    }

    func sessionReachabilityDidChange(_ session: WCSession) {
        watchConnected = session.isReachable
    }

    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        DispatchQueue.main.async {
            if let seizure = message["seizure"] as? Bool, seizure,
               let timestamp = message["timestamp"] as? TimeInterval,
               let intensity = message["intensity"] as? Double {
                self.isSeizureOngoing = true
                let event = SeizureEvent(
                    id: UUID(),
                    timestamp: Date(timeIntervalSince1970: timestamp),
                    intensity: intensity
                )
                self.historyManager?.addEvent(event)
            }

            if let monitoring = message["monitoring"] as? Bool {
                self.isMonitoringOnWatch = monitoring
            }
        }
    }

    // ✅ Obligatoire sur iOS, même si vide :
    func sessionDidBecomeInactive(_ session: WCSession) { }

    func sessionDidDeactivate(_ session: WCSession) { }
}
