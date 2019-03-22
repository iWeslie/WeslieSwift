/*:
 * Extension+CMDeviceMotion.swift
 * Created by Weslie
 * Copyright © 2019 Weslie. All rights reserved.
 */

import UIKit
import SceneKit
import CoreMotion

extension CMDeviceMotion {
    func gaze(atOrientation orientation: UIInterfaceOrientation) -> SCNVector4 {
        let attitude = self.attitude.quaternion
        let aq = GLKQuaternionMake(Float(attitude.x), Float(attitude.y), Float(attitude.z), Float(attitude.w))
        let final: SCNVector4
        switch orientation {
        case .landscapeRight:
            let cq = GLKQuaternionMakeWithAngleAndAxis(.pi / 2, 0, 1, 0)
            let q = GLKQuaternionMultiply(cq, aq)
            final = SCNVector4(x: -q.y, y: q.x, z: q.z, w: q.w)
        case .landscapeLeft:
            let cq = GLKQuaternionMakeWithAngleAndAxis(-.pi / 2, 0, 1, 0)
            let q = GLKQuaternionMultiply(cq, aq)
            final = SCNVector4(x: q.y, y: -q.x, z: q.z, w: q.w)
        case .portraitUpsideDown:
            let cq = GLKQuaternionMakeWithAngleAndAxis(.pi / 2, 1, 0, 0)
            let q = GLKQuaternionMultiply(cq, aq)
            final = SCNVector4(x: -q.x, y: -q.y, z: q.z, w: q.w)
        case .unknown:
            fallthrough
        case .portrait:
            let cq = GLKQuaternionMakeWithAngleAndAxis(-.pi / 2, 1, 0, 0)
            let q = GLKQuaternionMultiply(cq, aq)
            final = SCNVector4(x: q.x, y: q.y, z: q.z, w: q.w)
        }
        return final
    }
}


// SceneKit camera motion control

/*
let motionManager = CMMotionManager()

override func viewDidLoad() {
    if motionManager.deviceMotionAvailable {

    motionManager.deviceMotionUpdateInterval = 0.017
    motionManager.startDeviceMotionUpdatesToQueue(NSOperationQueue(), withHandler: deviceDidMove)
}

func deviceDidMove(motion: CMDeviceMotion?, error: Error?) {
    if let motion = motion {
        let orientation = motion.gaze(atOrientation: UIApplication.sharedApplication().statusBarOrientation)
        cameraNode.orientation = orientation
    }
}
*/