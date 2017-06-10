//
//  chambaraViewController.swift
//  chambaland
//
//  Created by 西村　綾乃 on 2017/06/10.
//  Copyright © 2017年 aynishim. All rights reserved.
//

import UIKit
import SocketIO

class chambaraViewController: UIViewController {
    var bs:BattleSystem? = nil
    var timer: Timer? = nil
    var dispImageNo = 0
    @IBOutlet weak var waitImage: UIImageView!
    @IBOutlet weak var statusImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.bs = BattleSystem(
            user_id : getRandomStringWithLength(length: 32),
            start_hook : {
                () -> (Void) in
                print("start")
                self.waitImage.isHidden = true
                self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.onTimer), userInfo: nil, repeats: true)
                //self.timer?.fire()
                return
            },
            status_hook : {
                (status: String) -> (Void) in
                print(self.bs?.user_id)
                //SoundUtil.playSwordConflictSound()
                print(status)
                return
            },
            result_hook : {
                (result: Bool) -> (Void) in
                print(self.bs?.user_id)
                print(result)
                let paramaters = ["score": "20", "result": "true"]
                self.performSegue(withIdentifier: "resultSegue", sender: 1)
                return
            }
        );
        
        if bs != nil {
           ActionUtil.additionalViewDidLoad(bs: self.bs!)
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.bs?.join()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "resultSegue" {
            let resultViewController = segue.destination as! resultViewController
            resultViewController.result = sender as! Int
        }
    }
    
    func onTimer(timer: Timer) {
        print("onTimer")
        
        // 表示している画像の番号を元に画像を表示する
        displayImage()
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
            self.statusImageView.isHidden = true
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
