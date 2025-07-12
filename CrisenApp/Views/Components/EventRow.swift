import SwiftUI

struct EventRow: View {
    let event: SeizureEvent

    var body: some View {
        HStack {
            Text(event.timestamp, format: .dateTime)
            Spacer()
            Text("Intensité : \(event.intensity, specifier: "%.2f")")
        }
    }
}