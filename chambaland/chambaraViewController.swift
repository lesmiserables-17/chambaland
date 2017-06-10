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
    @IBOutlet weak var waitImage: UIImageView!
    @IBOutlet weak var countImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.bs = BattleSystem(
            user_id : getRandomStringWithLength(length: 32),
            start_hook : {
                () -> (Void) in
                print("start")
                self.waitImage.isHidden = true
                if self.bs != nil {
                    ActionUtil.additionalViewDidLoad(bs: self.bs!)
                }
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
        if segue.identifier == "resultSegue" {
            let resultViewController = segue.destination as! resultViewController
            resultViewController.result = sender as! Int
        }
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
