//
//  SearchRouteViewController.swift
//  MAKAR
//
//  Created by 박지윤 on 2023/12/25.
//

import UIKit

class SearchRouteViewController : BaseViewController {
    
    // MARK: Constants
    private enum Metric {
        static let searchRouteViewHeight = 188
    }
    
    // MARK: UI Components
    private let searchRouteView = SearchRouteView()
    private let searchRouteTableView = UITableView(frame: .zero, style: .plain)
    
        // TODO: FIX: DUMMYLIST
    let searchRouteList : [RouteData] = RouteData.searchRouteList

    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()

        view.backgroundColor = .background
        setSearchRouteTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        searchRouteTableView.reloadData()
    }
    
    // MARK: Configuration
    override func configureSubviews() {
        super.configureSubviews()
        
        view.addSubview(searchRouteView)
        
        searchRouteView.tapSwapStationButton = {[weak self] in
            guard let self else { return }
            postSwapStationButtonClicked()
        }
        
        searchRouteView.tapSourceSearchBar = {[weak self] in
            guard let self else { return }
            
            self.navigationController?.pushViewController(SourceSearchStationViewController(), animated: true)
            postSourceSearchBarClicked()
        }

        searchRouteView.tapDestinationSearchBar = {[weak self] in
            guard let self else { return }
            
            self.navigationController?.pushViewController(DestinationSearchStationViewController(), animated: true)
            postDestinationSearchBarClicked()
        }
        
        searchRouteView.tapSearchRouteButton = {[weak self] in
            guard let self else { return }
            postSearchRouteButtonClicked()
        }
    }
    
    // MARK: Layout
    override func makeConstraints() {
        super.makeConstraints()
        
        searchRouteView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(Metric.searchRouteViewHeight)
        }
    }
    
    // MARK: Networking
    private func postSwapStationButtonClicked(){
        print("swapStationButton clicked")
    }
    
    private func postSourceSearchBarClicked(){
        print("sourceSearchBar clicked")
    }
    
    private func postDestinationSearchBarClicked(){
        print("destinationSearchBar clicked")
    }
    
    private func postSearchRouteButtonClicked(){
        print("searchRouteButton clicked")
    }
    
    // MARK: NavigationBar
    private func setNavigationBar(){
        navigationItem.title = "경로 설정하기"
    }
    
    // MARK: Event
    func changeSearchBarText(sourceText : String, destinationText : String){
            self.searchRouteView.changeSearchBarText(sourceText: sourceText, destinationText: destinationText)
    }
    
}

    // MARK: TableView
extension SearchRouteViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchRouteList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "searchRouteTableViewCell", for: indexPath) as? SearchRouteTableViewCell
        else {
            return UITableViewCell()
        }
        cell.setData(data: searchRouteList[indexPath.row])
        cell.contentView.isHidden = true
        return cell
    }
    
    func setSearchRouteTableView(){
        view.addSubview(searchRouteTableView)
        
        searchRouteTableView.backgroundColor = .background
        searchRouteTableView.separatorStyle = .singleLine
        searchRouteTableView.rowHeight = UITableView.automaticDimension
        
        searchRouteTableView.snp.makeConstraints{
            $0.top.equalTo(searchRouteView.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        searchRouteTableView.register(SearchRouteTableViewCell.self, forCellReuseIdentifier: "searchRouteTableViewCell")
        searchRouteTableView.dataSource = self
        searchRouteTableView.delegate = self
    }
}
