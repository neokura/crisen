import SwiftUI

struct WatchMonitoringView: View {
    @EnvironmentObject var manager: SeizureDetectionManager
    @State private var isActive = false

    var body: some View {
        VStack(spacing: 10) {
            Text(manager.isConnectedToPhone ? "📲 iPhone connecté" : "⚠️ iPhone non détecté")
                .foregroundStyle(manager.isConnectedToPhone ? .green : .red)
                .font(.headline)

            if manager.isMonitoring {
                Text("🟢 Surveillance active")
                if manager.seizureDetected, let time = manager.lastSeizureTime {
                    Text("⚠️ Crise détectée à \(time.formatted(date: .omitted, time: .shortened))")
                        .foregroundStyle(.red)
                } else {
                    Text("✅ Aucune crise détectée")
                        .foregroundStyle(.green)
                }
            } else {
                Text("🔴 Surveillance inactive")
            }

            Button(manager.isMonitoring ? "Arrêter" : "Démarrer") {
                isActive.toggle()
                isActive ? manager.startMonitoring() : manager.stopMonitoring()
            }
        }
        .padding()
    }
}