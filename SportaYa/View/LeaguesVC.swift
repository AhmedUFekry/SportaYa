//
//  LeaguesVC.swift
//  SportaYa
//
//  Created by A7med Fekry on 26/04/2024.
//

import UIKit
import Alamofire
import Kingfisher
import SkeletonView
import Reachability


class LeaguesVC: UIViewController , LeaguesProtocol {
    
    
 
    @IBOutlet weak var imgPlaceHolder: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var namesSearchBar: UISearchBar!
    var presenter : LeaguesPresenter!

    //var coreData = CoreData.coreDataObj
    var PlayersDetails:[player] = []
    let dummyItems = Items(league_name: "Test", league_key: 0)
    var sport = ""
    var leagues:Leagues?
    var filteredLeagues:Leagues?
   // let fLeagus = Fetch()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = LeaguesPresenter()
        presenter.attachView(view: self)
        presenter.sport = sport
        self.title = "Leagues"
        self.navigationController?.navigationBar.prefersLargeTitles = false
        checkConnection()
        filteredLeagues = Leagues(success: 1, result: [dummyItems])
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: namesSearchBar)
        
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if leagues == nil{
            tableView.showAnimatedGradientSkeleton(usingGradient: .init(baseColor: .asbestos),
                                                   animation: nil,
                                                   transition: .crossDissolve(0.25))
        }
    }
    
    func checkConnection(){
        let reachability = try! Reachability()
        
        if reachability.connection != .unavailable {
            presenter.fetchLeagues()
        } else {
            self.tableView.isHidden = true
            self.imgPlaceHolder.image = UIImage(named: "no_internet")
        }
    }
    
    
    
    func fetchLeagues(result: Int){
       // fLeagus.fetchLeagues(sport: sport) { [weak self] result in
           // guard let self = self else {return}
        if result == 1{
            
            self.leagues = presenter.leagues
            self.filteredLeagues = presenter.leagues
            self.tableView.hideSkeleton(reloadDataAfter: true, transition: .crossDissolve(0.25))
        }else{
                //print(error)
                self.tableView.hideSkeleton(reloadDataAfter: true, transition: .crossDissolve(0.25))
                self.tableView.isHidden = true
                self.imgPlaceHolder.image = UIImage(named: "no_internet")
                self.filteredLeagues = nil

                
            }
      //  }
    }
    
}

extension LeaguesVC: UITableViewDelegate,SkeletonTableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return filteredLeagues?.result?.count ?? 0
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! LeaguesCells
        guard let result = filteredLeagues?.result else {return cell}
        
        cell.label.text = result[indexPath.row].league_name
        cell.backView.layer.cornerRadius = 20
        cell.backView.backgroundColor = .systemGray5
        cell.backView.layer.shadowRadius = 3
        cell.backView.layer.shadowOpacity = 0.5
        cell.backView.layer.shadowOffset = CGSize(width: 5, height: 5)
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor.clear
        cell.selectedBackgroundView = backgroundView
        
        let url = URL(string: result[indexPath.row].league_logo ?? "")
        
        switch sport{
        case "football":
            cell.imageV.kf.setImage(with: url, placeholder:UIImage(named: "1"))
        case "basketball":
            cell.imageV.kf.setImage(with: url, placeholder:UIImage(named: "2"))
        case "cricket":
            cell.imageV.kf.setImage(with: url, placeholder:UIImage(named: "3"))
        default:
            cell.imageV.kf.setImage(with: url, placeholder:UIImage(named: "4"))
        }
        // save favourite button state
        let favLeagues = presenter.coreData.fetchTeams()
        if favLeagues.count == 0 {
            cell.addLeagueToFavbtn.isSelected = false
            cell.addLeagueToFavbtn.setImage(UIImage(systemName: "heart"), for: .normal)
        }
        for favLeague in favLeagues {
            if result[indexPath.row].league_key == favLeague.value(forKey: "leagueID") as! Int {
                cell.addLeagueToFavbtn.isSelected = true
                cell.addLeagueToFavbtn.setImage(UIImage(systemName: "heart.fill"), for: .normal)
                break
            } else {
                cell.addLeagueToFavbtn.isSelected = false
                cell.addLeagueToFavbtn.setImage(UIImage(systemName: "heart"), for: .normal)
            }
        }
        //COREDATA NEW
        cell.favLeague = { [unowned self] in
            
            if cell.addLeagueToFavbtn.isSelected == false{
                cell.addLeagueToFavbtn.isSelected = true
            }else {
                cell.addLeagueToFavbtn.isSelected = false
            }
            if cell.addLeagueToFavbtn.isSelected {
                
                cell.addLeagueToFavbtn.setImage(UIImage(systemName: "heart.fill"), for: .normal)
                
                presenter.coreData.save(sportName: result[indexPath.row].league_name, leagueID: result[indexPath.row].league_key, teamName: result[indexPath.row].league_name, teamLogo: result[indexPath.row].league_logo ?? "LPlace", players: PlayersDetails)
                    
            } else {
                cell.addLeagueToFavbtn.setImage(UIImage(systemName: "heart"), for: .normal)
                presenter.coreData.del(sportName: result[indexPath.row].league_name, leagueID: result[indexPath.row].league_key, teamName: result[indexPath.row].league_name)
                
            }
            
        }
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return tableView.bounds.height / 6.3
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let secVc = self.storyboard?.instantiateViewController(withIdentifier: "LeagueDetailsVC") as! LeagueDetailsVC
        
        secVc.sport = sport
        secVc.leagueID = filteredLeagues?.result?[indexPath.row].league_key ?? 0
        secVc.leagueName = filteredLeagues?.result?[indexPath.row].league_name ?? ""
        
        self.navigationController?.pushViewController(secVc, animated: true)
    }
    
    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return "cell"
    }
    
    
    func collectionSkeletonView(_ skeletonView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    func collectionSkeletonView(_ skeletonView: UITableView, skeletonCellForRowAt indexPath: IndexPath) -> UITableViewCell? {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! LeaguesCells
        cell.imageV.layer.cornerRadius = cell.imageV.bounds.width / 2
        return cell
    }
    
}


extension LeaguesVC:UISearchBarDelegate{
    
    //    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    //        if searchText != ""{
    //            filteredLeagues?.result?.removeAll()
    //            self.filteredLeagues?.result = self.leagues?.result?.filter{
    //                $0.league_name.contains(searchText)}
    //            self.tableView.reloadData()
    //        }else{
    //            self.filteredLeagues?.result = self.leagues?.result
    //            self.tableView.reloadData()
    //        }
    //    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            filteredLeagues = leagues
            tableView.reloadData()
        } else {
            filteredLeagues?.result = leagues?.result?.filter{
                $0.league_name.lowercased().contains(searchText.lowercased()) }
            tableView.reloadData()
        }
    }
    
}


extension LeaguesVC:UIScrollViewDelegate{
    
}
