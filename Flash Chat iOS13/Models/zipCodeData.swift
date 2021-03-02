//
//  zipCodeData.swift
//  EService
//
//  Created by admin on 2021-02-09.
//  Copyright © 2021 Angela Yu. All rights reserved.
//

import Foundation

struct zipCodeData:Codable {
    let item:Item
}

struct Item: Codable {
    let City: String
    let Province: String
    let PostalCode:String
}

