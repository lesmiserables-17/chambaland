//
//  TrialMotionSensor.swift
//  MotionSensor
//
//  Created by 佐々木　明 on 2017/06/10.
//  Copyright © 2017年 佐々木　明. All rights reserved.
//

import UIKit
import CoreMotion

class ActionUtil {
    
    // MotionManager
    static let motionManager = CMMotionManager()
    static let guardThreshold = 0.9
    static let cutThreshold = 1.8
    
    static func additionalViewDidLoad(bs: BattleSystem) {
        // Do any additional setup after loading the view, typically from a nib.
        
        if motionManager.isAccelerometerAvailable {
            // 加速度センサーの値取得間隔
            motionManager.accelerometerUpdateInterval = 1.0
            
            // motionの取得を開始
            motionManager.startAccelerometerUpdates(to: OperationQueue.current!, withHandler: { (data, error) in
                // 取得した値をコンソールに表示
                var flagCut = false
                var flagGuard = false
                print("x: \(data?.acceleration.x) y: \(data?.acceleration.y) z: \(data?.acceleration.z)")
                let accelNorm = sqrt(data!.acceleration.x * data!.acceleration.x + data!.acceleration.y * data!.acceleration.y + data!.acceleration.z * data!.acceleration.z)
                if accelNorm > self.cutThreshold {
                    print("Cut!")
                    flagCut = true
                }
                
                let accelXAbs = fabs(data!.acceleration.x)
                if accelXAbs > self.guardThreshold && !flagCut {
                    print("Guard!")
                    flagGuard = true
                }
                if flagCut {
                    bs.attack()
                }
                if flagGuard {
                    bs.defence()
                }
                
            }
            )
        }
    }
}
