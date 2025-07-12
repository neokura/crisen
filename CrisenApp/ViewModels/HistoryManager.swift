import SwiftUI

class HistoryManager: ObservableObject {
    @Published var events: [SeizureEvent] = []

    func addEvent(_ event: SeizureEvent) {
        events.append(event)
        events.sort { $0.timestamp > $1.timestamp }
    }
}
