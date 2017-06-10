//
//  SoundUtil.swift
//  single-view-sample
//
//  Created by 河端 洋人 on 2017/06/10.
//  Copyright © 2017年 河端　洋人. All rights reserved.
//

import Foundation
import AudioToolbox

class SoundUtil {
    
    class func vibrate() {
        AudioServicesPlaySystemSoundWithCompletion(kSystemSoundID_Vibrate){}
    }
    
    class func playSwordConflictSound() {
        let soundNum = arc4random_uniform(3) + 1
        print("sword_conflict\(soundNum)")
        let soundUrl = Bundle.main.url(forResource: "sword_conflict\(soundNum)", withExtension: "mp3")! as CFURL
        var soundId: SystemSoundID = 0
        AudioServicesCreateSystemSoundID(soundUrl, &soundId)
        AudioServicesPlaySystemSoundWithCompletion(soundId){}
    }
    
    class func playSwordGuardSound() {
        let soundUrl = Bundle.main.url(forResource: "sword_guard", withExtension: "mp3")! as CFURL
        var soundId: SystemSoundID = 1
        AudioServicesCreateSystemSoundID(soundUrl, &soundId)
        AudioServicesPlaySystemSoundWithCompletion(soundId){}
    }
    
    class func playSwordSwingSound() {
        let soundUrl = Bundle.main.url(forResource: "sword_swing", withExtension: "mp3")! as CFURL
        var soundId: SystemSoundID = 1
        AudioServicesCreateSystemSoundID(soundUrl, &soundId)
        AudioServicesPlaySystemSoundWithCompletion(soundId){}
    }
    
    class func playInjuredSound() {
        let soundUrl = Bundle.main.url(forResource: "injured", withExtension: "mp3")! as CFURL
        var soundId: SystemSoundID = 2
        AudioServicesCreateSystemSoundID(soundUrl, &soundId)
        AudioServicesPlaySystemSoundWithCompletion(soundId){}
    }
    
    class func playSystemSound() {
        AudioServicesPlaySystemSoundWithCompletion(1000){}
    }
}
