import Foundation

struct SeizureEvent: Identifiable, Codable {
    let id: UUID
    let timestamp: Date
    let intensity: Double
}