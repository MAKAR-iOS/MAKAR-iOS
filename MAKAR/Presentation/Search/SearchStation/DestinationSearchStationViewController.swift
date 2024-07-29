//
//  DestinationSearchStationViewController.swift
//  MAKAR
//
//  Created by 김다은 on 12/27/23.
//

import UIKit
class DestinationSearchStationViewController : BaseSearchStationViewController {
    
    // MARK: Constants
    private enum Metric {
        static let viewHeight = 125
    }
    
    // MARK: UI Components
    private let destinationSearchStationView = DestinationSearchStationView()
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()

        view.backgroundColor = .background
    }
    
    // MARK: Configuration
    override func configureSubviews() {
        super.configureSubviews()
        
        view.addSubview(destinationSearchStationView)
        
        destinationSearchStationView.tapHomeButton = {[weak self] in
            guard let self else { return }
            
            navigationController?.popViewController(animated: true)
            postHomeButtonClicked()
        }
        
        destinationSearchStationView.tapSchoolButton = {[weak self] in
            guard let self else { return }
            
            navigationController?.popViewController(animated: true)
            postSchoolButtonClicked()
        }
        
       destinationSearchStationView.tapMoreButton = {[weak self] in
            guard let self else { return }
           
           self.navigationController?.pushViewController(FavoriteStationViewController(), animated: true)
            postMoreButtonClicked()
        }
    }
    
    // MARK: Layout
    override func makeConstraints() {
        super.makeConstraints()
        
        destinationSearchStationView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(Metric.viewHeight)
        }
    }
    
    // MARK: Networking
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
    private func setNavigationBar(){
        navigationItem.title = "도착역 입력"
    }
    
    // MARK: TableView
    override func setTableView() {
        super.setTableView()
        
        tableView.snp.makeConstraints{
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(Metric.viewHeight)
        }
    }
}

extension DestinationSearchStationViewController {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        //TableView Networking Test
        print("DestinationSearchStationVC : cell -> \(cell!.textLabel!.text)")
        navigationController?.popViewController(animated: true)
    }
}
