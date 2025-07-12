import SwiftUI

struct TrackingView: View {
    @EnvironmentObject var connectivityManager: ConnectivityManager

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Image(systemName: connectivityManager.watchConnected ? "applewatch" : "applewatch.slash")
                    .font(.largeTitle)
                Text(connectivityManager.watchConnected ? "Apple Watch connectée" : "Apple Watch déconnectée")

                if connectivityManager.isMonitoringOnWatch {
                    Text("🟢 Surveillance active")
                    if connectivityManager.isSeizureOngoing {
                        Text("⚠️ Crise détectée")
                            .foregroundStyle(.red)
                            .font(.title)
                    } else {
                        Text("✅ Aucune crise détectée")
                            .foregroundStyle(.green)
                            .font(.title2)
                    }
                } else {
                    Text("🔴 Surveillance inactive")
                }
            }
            .navigationTitle("Suivi")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
