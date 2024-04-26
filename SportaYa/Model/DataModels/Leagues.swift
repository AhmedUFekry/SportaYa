//
//  Leagues.swift
//  SportaYa
//
//  Created by A7med Fekry on 25/04/2024.
//

import Foundation
struct Leagues: Codable{
    var success:Int
    var result:[Items]?
    init(success: Int, result: [Items]? = nil) {
        self.success = success
        self.result = result
    }
}

struct Items: Codable{
    var league_name:String
    var league_key:Int
    var league_logo:String?
    
}
