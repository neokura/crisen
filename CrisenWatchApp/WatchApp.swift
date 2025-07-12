import SwiftUI

@main
struct CrisenWatchApp: App {
    @StateObject var manager = SeizureDetectionManager()

    var body: some Scene {
        WindowGroup {
            WatchMonitoringView()
                .environmentObject(manager)
        }
    }
}