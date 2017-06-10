//
//  speedViewController.swift
//  chambaland
//
//  Created by 西村　綾乃 on 2017/06/10.
//  Copyright © 2017年 aynishim. All rights reserved.
//

import UIKit
import SocketIO

class speedViewController: UIViewController {
    var bs:BattleSystem? = nil
    var timer: Timer? = nil
    var dispImageNo = 0
    var fireTime: String = ""
    @IBOutlet weak var waitImage: UIImageView!
    @IBOutlet weak var statusImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.bs = BattleSystem(
            user_id : getRandomStringWithLength(length: 32),
            mode: "speed",
            start_hook : {
                (date: String) -> (Void) in
                print("start")
                print(date)
                self.fireTime = date
                self.waitImage.isHidden = true
                self.statusImageView.backgroundColor = UIColor.black
                
                self.timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.onTimer), userInfo: nil, repeats: true)
                
                return
        },
            status_hook : {
                (status: String) -> (Void) in
                return
        },
            result_hook : {
                (result: Bool) -> (Void) in
                print(self.bs?.user_id)
                print(result)
                ActionUtil.finishOffAccelerometer()
                SoundUtil.playStopSound()
                self.performSegue(withIdentifier: "speedResultSegue", sender: result)
                return
        }
        );
        
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //sleep(10)
        //self.bs?.join()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "speedResultSegue" {
            let resultViewController = segue.destination as! resultViewController
            resultViewController.result = sender as! Bool
        }
    }
    
    func onTimer(timer: Timer) {
        print("onTimer")
        let now = currentTimeMillis()
        print(now)
        print(self.fireTime)
        
        if (Int(now) > Int(self.fireTime)!){
            self.timer?.invalidate()
            self.timer = nil
            SoundUtil.playStartSound()
            if self.bs != nil {
                ActionUtil.additionalViewDidLoad(bs: self.bs!, mode: "speed")
            }
            return
        }
    }
    
    func currentTimeMillis() -> Int64{
        let nowDouble = NSDate().timeIntervalSince1970
        return Int64(nowDouble*1000)
    }
    
    func displayImage() {
        let imageNameArray = [
            "count3",
            "count2",
            "count1",
            "countGo"
        ]
        if dispImageNo > 3 {
            self.timer?.invalidate()
            self.timer = nil
            self.statusImageView.backgroundColor = UIColor.black
            self.statusImageView.image = nil
            SoundUtil.playStartSound()
            if self.bs != nil {
                ActionUtil.additionalViewDidLoad(bs: self.bs!, mode: "speed")
            }
            return
        }
        
        let name = imageNameArray[dispImageNo]
        let image = UIImage(named: name)
        self.statusImageView.image = image
        
        dispImageNo += 1
    }
    
    func getRandomStringWithLength(length: Int) -> String {
        
        let alphabet = "1234567890abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
        let upperBound = UInt32(alphabet.characters.count)
        
        return String((0..<length).map { _ -> Character in
            //            return alphabet[alphabet.startIndex.advancedBy(Int(arc4random_uniform(upperBound)))]
            return alphabet[alphabet.index(alphabet.startIndex, offsetBy: Int(arc4random_uniform(upperBound)))]
        })
    }
    
}
