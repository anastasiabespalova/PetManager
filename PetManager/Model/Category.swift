//
//  Category.swift
//  PetManager
//
//  Created by Анастасия Беспалова on 10.09.2021.
//


import Foundation

class Category: Identifiable {
    var name: String
    var number: Int
    
    init(name: String, number: Int) {
        self.name = name
        self.number = number
    }
    
    var id: UUID { UUID() }
}
