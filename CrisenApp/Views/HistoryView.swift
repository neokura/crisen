import SwiftUI

struct HistoryView: View {
    @EnvironmentObject var historyManager: HistoryManager

    var body: some View {
        NavigationStack {
            List(historyManager.events) { event in
                EventRow(event: event)
            }
            .navigationTitle("Historique")
        }
    }
}