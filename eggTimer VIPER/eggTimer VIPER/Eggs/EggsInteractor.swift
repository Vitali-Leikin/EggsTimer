//
//  EggsInteractor.swift
//  eggTimer VIPER
//
//  Created by vitali on 10.10.2023.
//

import AVFoundation




protocol EggsInteractorInputProtocol{
    init(presenter: EggsInteractorOutputProtocol)
    func receiveEggs(nameButton: String)
}
protocol EggsInteractorOutputProtocol: AnyObject{
    
    func receiveEggsTitle(title: Float)
    func receiveEggsProgress(progress: Float)
    func receiveEggsDoneTitle(title: String)
    
    
}

class EggsInteractor: EggsInteractorInputProtocol {
    private var timer: Timer
    private  var totalTime: Int
    private var secondsPassed: Int
    private var player: AVAudioPlayer!
    
    unowned let presenter: EggsInteractorOutputProtocol
    
    required init(presenter: EggsInteractorOutputProtocol) {
        self.presenter = presenter
        timer = Timer()
        totalTime = 0
        secondsPassed = 1
    }
    
    func receiveEggs(nameButton: String) {
        let eggs = EggModel.fetchEggs()
        var indexEgg = 0
        for (count, item) in eggs.enumerated(){
            if item.typeDone == nameButton{
                indexEgg = count
            }
        }
        totalTime = eggs[indexEgg].time
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timeUpdate), userInfo: nil, repeats: true)
        timer.fire()
        
    }
    
    
    @objc private func timeUpdate(){
        if secondsPassed <= totalTime {
            presenter.receiveEggsProgress(progress: Float(secondsPassed) / Float(totalTime))
            presenter.receiveEggsTitle(title: Float(secondsPassed))
            secondsPassed += 1
        }else{
            playSound()
            restart()
            
        }
    }
    
    private func resetTimer(){
        secondsPassed = 1
        timer.invalidate()
    }
    
    private func restart(){
        resetTimer()
        presenter.receiveEggsDoneTitle(title: "Done" )
    }
    
    private  func playSound() {
        let url = Bundle.main.url(forResource: "C", withExtension: "wav")
        player = try! AVAudioPlayer(contentsOf: url!)
        player.play()
        
    }
}
