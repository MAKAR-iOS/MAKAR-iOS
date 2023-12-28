//
//  BaseSearchStationViewController.swift
//  MAKAR
//
//  Created by 김다은 on 12/28/23.
//

import UIKit
class BaseSearchStationViewController : BaseViewController {
    
    var namelist = ["1", "2", "3", "4", "5"]
    var tableView = UITableView(frame: .zero, style: .plain)
    
    // MARK: UI Components
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
    }
    
    // MARK: Configuration
    override func configureSubviews() {
        super.configureSubviews()
        
    }
    
    // MARK: Layout
    override func makeConstraints() {
        super.makeConstraints()

    }
    
    // MARK: TableView
    func setTableView(){
        view.addSubview(tableView)
        tableView.backgroundColor = .background
        
        tableView.snp.makeConstraints{
            $0.trailing.leading.bottom.equalToSuperview()
        }
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
    }
}

extension BaseSearchStationViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return namelist.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "dummylist") ?? UITableViewCell(style: .default, reuseIdentifier: "dummylist")

        cell.backgroundColor = .background
        cell.textLabel?.text = namelist[indexPath.row]
        cell.textLabel?.font = UIFont.systemFont(ofSize: 15)
        cell.textLabel?.textColor = UIColor.black
        return cell
    }
}
