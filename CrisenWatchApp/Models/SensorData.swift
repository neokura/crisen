import CoreMotion

struct SensorData {
    let timestamp: Date
    let accelerometerData: CMAccelerometerData?
    let gyroData: CMGyroData?
}