//
//  EggTime.swift
//  EggTimer
//
//  Created by vitali on 26.09.2023.
//  Copyright © 2023 The App Brewery. All rights reserved.
//

import Foundation


struct EggTime{
    let typeDone: String
    let time: Int
    
    static func fetchEggs() ->[EggTime] {
        return [
            EggTime(typeDone: "Soft", time: 5),
            EggTime(typeDone: "Medium", time: 8),
            EggTime(typeDone: "Hard", time: 12)
        ]
    }
}


