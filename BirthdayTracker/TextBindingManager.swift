//
//  TextBindingManager.swift
//  BirthdayTracker
//
//  Created by Viktor Goleš on 28.11.2022..
//

import Foundation

class TextBindingManager: ObservableObject {
    @Published var text = "" {
        didSet {
            if text.count > characterLimit && oldValue.count <= characterLimit {
                text = oldValue
            }
        }
    }
    let characterLimit: Int

    init(limit: Int = 20){
        characterLimit = limit
    }
}
