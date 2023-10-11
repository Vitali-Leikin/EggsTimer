//
//  EggsConfigurator.swift
//  eggTimer VIPER
//
//  Created by vitali on 10.10.2023.
//

import Foundation

protocol EggsConfiguratorInputProtocol{
    func configure(with view: EggsViewController)
}


class EggsConfigurator: EggsConfiguratorInputProtocol{
    func configure(with view: EggsViewController) {
        let presenter = EggsPresenter(view: view)
        let interactor = EggsInteractor(presenter: presenter)
        view.presenter = presenter
        presenter.interactor = interactor
    }
}

