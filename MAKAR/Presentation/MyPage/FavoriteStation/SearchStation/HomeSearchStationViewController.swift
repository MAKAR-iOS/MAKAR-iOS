//
//  HomeSearchStationViewController.swift
//  MAKAR
//
//  Created by 김다은 on 12/28/23.
//

import UIKit
class HomeSearchStationViewController : BaseSearchStationViewController {
    
    // MARK: Constants
    private enum Metric {
        static let viewHeight = 80
    }
    
    // MARK: UI Components
    private let homeSearchStationView = HomeSearchStationView()
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .background
    }
    
    // MARK: Configuration
    override func configureSubviews() {
        super.configureSubviews()
        
        view.addSubview(homeSearchStationView)
    }
    
    // MARK: Layout
    override func makeConstraints() {
        super.makeConstraints()
        
        homeSearchStationView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(Metric.viewHeight)
        }
    }
    
    // MARK: NavigationBar
    override func setNavigationBar(){
        navigationItem.title = "역 검색"
    }
    
    // MARK: TableView
    override func setTableView() {
        super.setTableView()
        
        tableView.snp.makeConstraints{
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(Metric.viewHeight)
        }
    }
}

extension HomeSearchStationViewController {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        //TableView Networking Test
        print("HomeSearchStationVC : cell -> \(cell!.textLabel!.text)")
        navigationController?.popViewController(animated: true)
    }
}
