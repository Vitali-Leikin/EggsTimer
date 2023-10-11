//
//  EggModel.swift
//  eggTimer VIPER
//
//  Created by vitali on 10.10.2023.
//

import Foundation
struct EggModel{
    let typeDone: String
    let time: Int
    
    static func fetchEggs() ->[EggModel] {
        return [
            EggModel(typeDone: "Soft", time: 5),
            EggModel(typeDone: "Medium", time: 8),
            EggModel(typeDone: "Hard", time: 12)
        ]
    }
}
