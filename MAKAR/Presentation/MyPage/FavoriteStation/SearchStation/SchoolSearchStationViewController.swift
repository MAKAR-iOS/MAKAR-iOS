//
//  SchoolSearchStationViewController.swift
//  MAKAR
//
//  Created by 김다은 on 12/28/23.
//

import UIKit
class SchoolSearchStationViewController : BaseSearchStationViewController {
    
    // MARK: Constants
    private enum Metric {
        static let viewHeight = 80
    }
    
    // MARK: UI Components
    private let schoolSearchStationView = SchoolSearchStationView()
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()

        view.backgroundColor = .background
    }
    
    // MARK: Configuration
    override func configureSubviews() {
        super.configureSubviews()
        
        view.addSubview(schoolSearchStationView)
    }
    
    // MARK: Layout
    override func makeConstraints() {
        super.makeConstraints()
        
        schoolSearchStationView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(Metric.viewHeight)
        }
    }
    
    // MARK: NavigationBar
    private func setNavigationBar(){
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

extension SchoolSearchStationViewController {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        //TableView Networking Test
        print("SchoolSearchStationVC : cell -> \(cell!.textLabel!.text)")
        navigationController?.popViewController(animated: true)
    }
}
