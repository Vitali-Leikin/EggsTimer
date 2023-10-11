//
//  ViewController.swift
//  EggsTimer_MVVM
//
//  Created by vitali on 11.10.2023.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - @IBOutlet
    @IBOutlet weak var titleLabelText: UILabel!
    @IBOutlet weak var progressBarView: UIProgressView!
    @IBOutlet var buttonEggsOutlet: [UIButton]!
    
    private var viewModel: TimerViewModelProtocol!{
        didSet{
            viewModel.timerDidChanged = { [unowned self] viewModel in
                titleLabelText.text = viewModel.title
                progressBarView.progress = viewModel.valueProgress
            }
        }
    }
    let arrayEgg = EggTime.fetchEggs()
    // MARK: - lifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = TimerViewModel(egg: arrayEgg)
        progressBarView.progress = viewModel.valueProgress
        setupButton()
    }
    // MARK: - @IBAction
    @IBAction func hardnessSelectedButton(_ sender: UIButton) {
        sender.animatedBtn()
        viewModel.buttonWasTapped(senderTitle: sender.currentTitle ?? "error")
    }
    
    func setupButton(){
        for (button, egg) in zip(buttonEggsOutlet, arrayEgg){
            print(egg.typeDone)
            button.setTitle(egg.typeDone, for: .normal)
        }
    }
}


extension UIButton {
    func animatedBtn(){
        let pulse = CASpringAnimation(keyPath: "transform.scale")
        pulse.fromValue = 0.95
        pulse.toValue = 1
        pulse.duration = 0.3
        pulse.autoreverses = true
        pulse.repeatCount  = 1
        pulse.initialVelocity = 0.5
        pulse.damping = 0.1
        layer.add(pulse, forKey: nil)
    }
}
