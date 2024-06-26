//
//  Fixtures.swift
//  SportaYa
//
//  Created by A7med Fekry on 25/04/2024.
//

import Foundation

class Fixtures : Codable {
    
    var success : Int?
    var result : [matchs]?
    
}

class matchs : Codable{
    var event_date : String?
    var event_time : String?
    var event_away_team : String?
    var event_home_team : String?
    var event_final_result :String?
    var league_name : String?
    var league_round : String?
    var league_logo : String?
    var home_team_logo : String?
    var away_team_logo : String?
    var event_home_team_logo:String?
    var event_away_team_logo:String?
    var league_season : String?
    var event_live : String?
    var event_stadium : String?
    var event_date_start:String?  // creccit
    var event_home_final_result:String? // creccit
    var event_away_final_result:String? // creccit
    var event_first_player: String? // tennis
    //var first_player_key: String? // tennis
    var event_second_player: String? // tennis
    //var second_player_key:String? // tennis
    var player:String?
    var event_first_player_logo:String?
    var event_second_player_logo:String?
}
