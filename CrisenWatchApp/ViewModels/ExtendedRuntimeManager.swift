import WatchKit

class ExtendedRuntimeManager: NSObject, WKExtendedRuntimeSessionDelegate {
    private var session = WKExtendedRuntimeSession()

    func start() {
        session.delegate = self
        session.start()
    }

    func stop() {
        session.invalidate()
    }

    func extendedRuntimeSessionDidStart(_ session: WKExtendedRuntimeSession) {}
    func extendedRuntimeSessionWillExpire(_ session: WKExtendedRuntimeSession) {}
    func extendedRuntimeSession(_ session: WKExtendedRuntimeSession, didInvalidateWith reason: WKExtendedRuntimeSessionInvalidationReason, error: Error?) {}
}