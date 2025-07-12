import Foundation
import WatchConnectivity

class SeizureDetectionManager: NSObject, ObservableObject, WCSessionDelegate {
    private let workoutManager = WorkoutManager()
    private let runtimeManager = ExtendedRuntimeManager()
    private let sensorProcessor = SensorDataProcessor()

    @Published var isMonitoring = false
    @Published var isConnectedToPhone = false
    @Published var seizureDetected = false
    @Published var lastSeizureTime: Date? = nil

    override init() {
        super.init()
        setupConnectivity()
    }

    func setupConnectivity() {
        if WCSession.isSupported() {
            let session = WCSession.default
            session.delegate = self
            session.activate()
        }
    }

    func startMonitoring() {
        workoutManager.startWorkout()
        runtimeManager.start()
        isMonitoring = true

        sensorProcessor.startProcessing { data in
            self.analyze(data)
        }
    }

    func stopMonitoring() {
        workoutManager.stopWorkout()
        runtimeManager.stop()
        sensorProcessor.stopProcessing()
        isMonitoring = false
    }

    private func analyze(_ data: SensorData) {
        if let acc = data.accelerometerData,
           abs(acc.acceleration.x) > 2.0 ||
           abs(acc.acceleration.y) > 2.0 ||
           abs(acc.acceleration.z) > 2.0 {
            
            DispatchQueue.main.async {
                self.seizureDetected = true
                self.lastSeizureTime = data.timestamp
            }

            let message: [String: Any] = [
                "seizure": true,
                "timestamp": data.timestamp.timeIntervalSince1970,
                "intensity": 2.4
            ]
            WCSession.default.sendMessage(message, replyHandler: nil, errorHandler: nil)
        }
    }

    // MARK: - WCSessionDelegate (watchOS-compatible)
    
    func session(_ session: WCSession, activationDidCompleteWith state: WCSessionActivationState, error: Error?) {
        DispatchQueue.main.async {
            self.isConnectedToPhone = session.isReachable
        }
    }

    func sessionReachabilityDidChange(_ session: WCSession) {
        DispatchQueue.main.async {
            self.isConnectedToPhone = session.isReachable
        }
    }
}
