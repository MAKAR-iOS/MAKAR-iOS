//
//  FavoriteRouteViewController.swift
//  MAKAR
//
//  Created by 김다은 on 1/11/24.
//

import UIKit
class FavoriteRouteViewController : BaseViewController {
    
    // MARK: UI Components
    let favoriteRouteTableView = UITableView(frame: .zero, style: .plain)
    
    // TODO: 최근 경로 리스트 조회 API 연결
    var favoriteRouteList : [Route] = Route.favoriteRouteList

    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()

        view.backgroundColor = .background
        setTableView()
    }
    
    // MARK: NavigationBar
    private func setNavigationBar(){
        navigationItem.title = "즐겨찾는 경로 설정"
    }
}

    // MARK: TableView
extension FavoriteRouteViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteRouteList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "favoriteRouteTableViewCell", for: indexPath) as? FavoriteRouteTableViewCell
        else {
            return UITableViewCell()
        }
        cell.setData(data: favoriteRouteList[indexPath.row])
        cell.contentView.isHidden = true
        
        //즐겨찾는 경로 삭제
        cell.tapDeleteRecentRouteButton = {[weak self] in
            guard let self else { return }
            HomeViewController.favoriteRouteList.remove(at: indexPath.row)
            favoriteRouteList = HomeViewController.favoriteRouteList
            favoriteRouteTableView.reloadData()
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data : Route = favoriteRouteList[indexPath.row]
        //searchBar Text 수정
        let sourceText = data.sourceStation.stationName + " " + data.sourceStation.lineNum
        let destinationText = data.destinationStation.stationName + " " + data.destinationStation.lineNum
        
        let searchRouteVC = SearchRouteViewController()
        searchRouteVC.changeSearchBarText(sourceText: sourceText, destinationText: destinationText)
        self.navigationController?.pushViewController(searchRouteVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 48
    }
    
    func setTableView(){
        view.addSubview(favoriteRouteTableView)

        favoriteRouteTableView.backgroundColor = .background
        favoriteRouteTableView.separatorStyle = .none
        
        favoriteRouteTableView.snp.makeConstraints{
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        favoriteRouteTableView.register(FavoriteRouteTableViewCell.self, forCellReuseIdentifier: "favoriteRouteTableViewCell")
        favoriteRouteTableView.dataSource = self
        favoriteRouteTableView.delegate = self
    }
}

