//
//  LeaguesPresenter.swift
//  SportaYa
//
//  Created by A7med Fekry on 01/05/2024.
//

import Foundation
import UIKit
class LeaguesPresenter{
    
   // var result :[Product]!
    weak var view : LeaguesProtocol!
    var coreData = CoreData.coreDataObj
    var PlayersDetails:[player] = []
    let dummyItems = Items(league_name: "Test", league_key: 0)
    var sport = ""
    var leagues:Leagues?
    var filteredLeagues:Leagues?
    let fLeagus = Fetch()
    
    func attachView(view : LeaguesProtocol){
        self.view = view
    }
    
    
    func fetchLeagues(){
        fLeagus.fetchLeagues(sport: sport) { [weak self] result in
            guard let self = self else {return}
            switch result{
            case .success(let leagues):
                self.leagues = leagues
                self.filteredLeagues = leagues
                DispatchQueue.main.async {
                    self.view.fetchLeagues(result: 1)
                }
                //self.tableView.hideSkeleton(reloadDataAfter: true, transition: .crossDissolve(0.25))
            case .failure(let error):
                print(error)
                DispatchQueue.main.async {
                    self.view.fetchLeagues(result: 0)
                }
              //  view.tableView.hideSkeleton(reloadDataAfter: true, transition: .crossDissolve(0.25))
              //  view.tableView.isHidden = true
             //   view.imgPlaceHolder.image = UIImage(named: "no_internet")
                self.filteredLeagues = nil

                
            }
        }
    }
    
    
}
