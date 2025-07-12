import SwiftUI

@main
struct CrisenApp: App {
    @StateObject private var connectivityManager = ConnectivityManager()
    @StateObject private var historyManager = HistoryManager()

    var body: some Scene {
        WindowGroup {
            TabView {
                TrackingView()
                    .tabItem { Label("Suivi", systemImage: "waveform.path.ecg") }

                HistoryView()
                    .tabItem { Label("Historique", systemImage: "list.bullet.rectangle") }
            }
            .environmentObject(connectivityManager)
            .environmentObject(historyManager)
        }
    }
}