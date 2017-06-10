//
//  resultViewController.swift
//  chambaland
//
//  Created by 西村　綾乃 on 2017/06/10.
//  Copyright © 2017年 aynishim. All rights reserved.
//

import UIKit

class resultViewController: UIViewController {
    var result: Bool = false
    
    @IBOutlet weak var resultView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        if result == true {
            resultView.image = UIImage(named: "winimg.png")
            SoundUtil.playCheerSound()
        } else {
            resultView.image = UIImage(named: "loseimg.png")
        }
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
