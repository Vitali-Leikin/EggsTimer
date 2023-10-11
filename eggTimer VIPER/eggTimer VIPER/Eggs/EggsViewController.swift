//
//  ViewController.swift
//  eggTimer VIPER
//
//  Created by vitali on 10.10.2023.
//

import UIKit

protocol EggsViewInputProtocol: AnyObject{
    func displayTitle(title: String)
    func displayProgress(progress: Float)
}

protocol EggsViewOutputProtocol{
    init(view: EggsViewInputProtocol)
    func didTappedEggsButton(name: String)
}

class EggsViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var progressBarView: UIProgressView!
    @IBOutlet var buttonEggsOutlets: [UIButton]!
    
    var presenter: EggsViewOutputProtocol!
    private let configurator: EggsConfigurator = EggsConfigurator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(with: self)
    }

    @IBAction func buttonEggsPressed(_ sender: UIButton) {
        sender.animatedButton()
        presenter.didTappedEggsButton(name: sender.titleLabel?.text ?? "error")
    }
    
}


extension EggsViewController: EggsViewInputProtocol{
    func displayTitle(title: String) {
        titleLabel.text = title
    }
    
    func displayProgress(progress: Float) {
        progressBarView.progress = progress
    }
    
}


extension UIButton {
    func animatedButton(){
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
