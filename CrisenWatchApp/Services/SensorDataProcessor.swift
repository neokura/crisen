import CoreMotion

class SensorDataProcessor {
    private let motionManager = CMMotionManager()

    func startProcessing(handler: @escaping (SensorData) -> Void) {
        motionManager.accelerometerUpdateInterval = 0.1
        motionManager.gyroUpdateInterval = 0.1

        motionManager.startAccelerometerUpdates()
        motionManager.startGyroUpdates()

        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
            let data = SensorData(
                timestamp: Date(),
                accelerometerData: self.motionManager.accelerometerData,
                gyroData: self.motionManager.gyroData
            )
            handler(data)
        }
    }

    func stopProcessing() {
        motionManager.stopAccelerometerUpdates()
        motionManager.stopGyroUpdates()
    }
}
