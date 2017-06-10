//
//  BattleSystem.swift
//  PodTest
//
//  Created by 蔵内　亮 on 2017/06/10.
//  Copyright © 2017年 rkurauch. All rights reserved.
//

import Foundation
import SocketIO

class BattleSystem {
    public var user_id: String
    var socket: SocketIOClient!
    var start_hook: () -> (Void)
    var status_hook: (String) -> (Void)
    var result_hook : (Bool) -> (Void)
    
    init(user_id:String,
         start_hook  :  @escaping () -> (Void),
         status_hook :  @escaping (String) -> (Void),
         result_hook :  @escaping (Bool) -> (Void)
        ) {
        self.user_id = user_id
        self.start_hook  = start_hook
        self.status_hook = status_hook
        self.result_hook = result_hook
        
        socket = SocketIOClient(
            //socketURL: URL(string: "https://667e425c.ngrok.io")!
            //socketURL: URL(string: "https://5d1388d4.ngrok.io")!
            socketURL: URL(string: "http://172.16.28.81")!
            //config: [.log(true), .forcePolling(true)]
            
        )
        
        socket.on(clientEvent: .connect) {data, ack in
            print("socket connected")
            self.join()
        }
        
        //socket = appDelegate.socket
        
        socket.on("start"){ data, ack in
            self.start_hook()
            
            self.socket.on("status"){ data, ack in
                print("status")
                let json = data[0] as? NSDictionary
                let result = json?[user_id] as! String
                switch result {
                    case "injured":
                        print("status: \(result)")
                        SoundUtil.playInjuredSound()
                    case "guard":
                        print("status: \(result)")
                        SoundUtil.playSwordGuardSound()
                    case "conflict":
                        print("status: \(result)")
                        SoundUtil.playSwordConflictSound()
                    default:
                        print("status: \(result)")
                }
                self.status_hook(json?[user_id] as! String)
                //self.status_hook(data[0] as! String)
            }
            
            self.socket.on("result"){ data, ack in
                self.socket.off("status")
                
                print("result")
                print(data[0])
                let json = data[0] as? NSDictionary
                let result = json?[user_id] as! Bool
                self.result_hook(result)
            }
        }
        
        socket.connect()
    }
    
    func join() {
        print("join")
        socket.emit("join", user_id)
    }
    
    func attack() {
        SoundUtil.playSwordSwingSound()
        socket.emit("attack",user_id)
    }
    
    func defence() {
        socket.emit("defence",user_id)
    }
    
    func close_connection() {
        socket.disconnect()
    }
}
