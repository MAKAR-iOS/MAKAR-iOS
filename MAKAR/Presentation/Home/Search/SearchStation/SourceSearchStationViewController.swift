//
//  SearchStationViewController.swift
//  MAKAR
//
//  Created by 박지윤 on 2023/12/25.
//

import UIKit
class SourceSearchStationViewController : BaseSearchStationViewController {
    
    // MARK: Constants
    private enum Metric {
        static let viewHeight = 125
    }
    
    // MARK: UI Components
    private let sourceSearchStationView = SourceSearchStationView()
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .background
    }
    
    // MARK: Configuration
    override func configureSubviews() {
        super.configureSubviews()
        
        view.addSubview(sourceSearchStationView)
        
        sourceSearchStationView.tapMyLocationButton = {[weak self] in
            guard let self else { return }
            postMyLocationButtonClicked()
        }
        
        sourceSearchStationView.tapHomeButton = {[weak self] in
            guard let self else { return }
            
            navigationController?.popViewController(animated: true)
            postHomeButtonClicked()
        }
        
        sourceSearchStationView.tapSchoolButton = {[weak self] in
            guard let self else { return }
            
            navigationController?.popViewController(animated: true)
            postSchoolButtonClicked()
        }
        
        sourceSearchStationView.tapMoreButton = {[weak self] in
            guard let self else { return }
            
            self.navigationController?.pushViewController(FavoriteStationViewController(), animated: true)
            postMoreButtonClicked()
        }
    }
    
    // MARK: Layout
    override func makeConstraints() {
        super.makeConstraints()
        
        sourceSearchStationView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(Metric.viewHeight)
        }
    }
    
    // MARK: Networking
    private func postMyLocationButtonClicked(){
        print("myLocationButton clicked")
    }
    
    private func postHomeButtonClicked(){
        print("homeButton clicked")
    }
    
    private func postSchoolButtonClicked(){
        print("schoolButton clicked")
    }
    
    private func postMoreButtonClicked(){
        print("moreButton clicked")
    }
    
    // MARK: NavigationBar
    override func setNavigationBar(){
        super.setNavigationBar()
        navigationItem.title = "출발역 입력"
    }
    
    // MARK: TableView
    override func setTableView() {
        super.setTableView()
        
        tableView.snp.makeConstraints{
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(Metric.viewHeight)
        }
    }
}

extension SourceSearchStationViewController {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        //TableView Networking Test
        print("SourceSearchStationVC : cell -> \(cell!.textLabel!.text)")
        navigationController?.popViewController(animated: true)
    }
}
