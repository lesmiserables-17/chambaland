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
        var soundId: SystemSoundID = 2
        AudioServicesCreateSystemSoundID(soundUrl, &soundId)
        AudioServicesPlaySystemSoundWithCompletion(soundId){}
    }
    
    class func playInjuredSound() {
        let soundNum = arc4random_uniform(2) + 1
        let soundUrl = Bundle.main.url(forResource: "injured\(soundNum)", withExtension: "mp3")! as CFURL
        var soundId: SystemSoundID = 3
        AudioServicesCreateSystemSoundID(soundUrl, &soundId)
        AudioServicesPlaySystemSoundWithCompletion(soundId){}
    }
    
    class func playStartSound() {
        let soundUrl = Bundle.main.url(forResource: "start", withExtension: "m4a")! as CFURL
        var soundId: SystemSoundID = 4
        AudioServicesCreateSystemSoundID(soundUrl, &soundId)
        AudioServicesPlaySystemSoundWithCompletion(soundId){}
    }
    
    class func playStopSound() {
        let soundUrl = Bundle.main.url(forResource: "stop", withExtension: "m4a")! as CFURL
        var soundId: SystemSoundID = 5
        AudioServicesCreateSystemSoundID(soundUrl, &soundId)
        AudioServicesPlaySystemSoundWithCompletion(soundId){}
    }
    
    class func playCheerSound() {
        let soundUrl = Bundle.main.url(forResource: "cheer", withExtension: "mp3")! as CFURL
        var soundId: SystemSoundID = 6
        AudioServicesCreateSystemSoundID(soundUrl, &soundId)
        AudioServicesPlaySystemSoundWithCompletion(soundId){}
    }
    
    class func playSystemSound() {
        AudioServicesPlaySystemSoundWithCompletion(1000){}
    }
}
