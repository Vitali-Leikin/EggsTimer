//
//  TimerViewModel.swift
//  EggTimer
//
//  Created by vitali on 26.09.2023.
//  Copyright © 2023 The App Brewery. All rights reserved.
//

import Foundation
import AVFoundation

enum SetValue{
    enum StartNumb: Int{
        case startSeconds = 1
        case start = 0
    }
    enum Step: Int{
        case one = 0
    }
    enum NameSound: String{
        case name = "C"
        case format = "wav"
    }
    
}


protocol TimerViewModelProtocol: AnyObject{
    var timerDidChanged: ((TimerViewModelProtocol) -> Void)? {get set}
    var valueProgress: Float {get}
    var title: String? {get}
    init(egg: [EggTime])
    func buttonWasTapped(senderTitle: String)
}

class TimerViewModel: TimerViewModelProtocol {
    private var player: AVAudioPlayer!
    private var timer: Timer
    private var totalTime: Int
    private var secondsPassed: Int
    private var egg: [EggTime]
    
    var title: String?
    var valueProgress: Float{
        didSet{
            timerDidChanged?(self)
        }
    }
    var timerDidChanged: ((TimerViewModelProtocol) -> Void)?
    
    required init(egg: [EggTime]) {
        self.egg = egg
        self.timer = Timer()
        self.totalTime = SetValue.StartNumb.start.rawValue
        self.secondsPassed = SetValue.StartNumb.startSeconds.rawValue
        self.valueProgress = Float(SetValue.StartNumb.start.rawValue)
    }
    
    func buttonWasTapped(senderTitle: String) {
        var indexEgg = SetValue.StartNumb.start.rawValue
        
        for (count, item) in egg.enumerated(){
            if item.typeDone == senderTitle{
                indexEgg = count
            }
        }
        totalTime = egg[indexEgg].time
        startTimer()
    }
    
    private func startTimer(){
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timeUpdate), userInfo: nil, repeats: true)
        timer.fire()
    }
    

    @objc private func timeUpdate(){
        print(secondsPassed)
        print(totalTime)
        if secondsPassed <= totalTime {
            title = "\(secondsPassed) sec"
            valueProgress = Float(secondsPassed) / Float(totalTime)
            secondsPassed += 1 
        }else{
            playSound()
            restart()
            
        }
   }

    private func restart(){
        secondsPassed = 1
        self.title = "Done"
        valueProgress = Float(SetValue.StartNumb.start.rawValue)
        timer.invalidate()
    }
    
    private  func playSound() {
        let url = Bundle.main.url(forResource: "music", withExtension: "wav")
        player = try! AVAudioPlayer(contentsOf: url!)
        player.play()
                
    }
}
