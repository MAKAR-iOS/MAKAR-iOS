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
    // TODO: 최근경로 리스트 데이터 수정
    var favoriteRouteList : [RouteData] = RouteData.favoriteRouteList

    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .background
        setTableView()
    }
    
    // MARK: NavigationBar
    override func setNavigationBar(){
        super.setNavigationBar()
        navigationItem.title = "즐겨찾는 경로 설정"
    }
}

    // MARK: TableView
extension FavoriteRouteViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteRouteList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "favoriteRouteTableViewCell") as? FavoriteRouteTableViewCell
        else {
            return UITableViewCell()
        }
        cell.setData(data: favoriteRouteList[indexPath.row])
        cell.backgroundColor = .background
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
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

