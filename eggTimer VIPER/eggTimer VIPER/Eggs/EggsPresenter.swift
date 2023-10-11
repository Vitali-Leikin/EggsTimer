//
//  EggsPresenter.swift
//  eggTimer VIPER
//
//  Created by vitali on 10.10.2023.
//

import Foundation

class EggsPresenter: EggsViewOutputProtocol{
 
    unowned let view: EggsViewInputProtocol
    var interactor: EggsInteractorInputProtocol!
    
    required init(view: EggsViewInputProtocol) {
        self.view = view
    }
    
    func didTappedEggsButton(name: String) {
        interactor.receiveEggs(nameButton: name)
    }

    
}

extension EggsPresenter: EggsInteractorOutputProtocol {
    func receiveEggsDoneTitle(title: String) {
        view.displayTitle(title: title)

    }
    
    func receiveEggsProgress(progress: Float) {
        view.displayProgress(progress: progress)
    }
    
    func receiveEggsTitle(title: Float) {
        view.displayTitle(title: "\(Int(title))")
       
    }
    
   


}
