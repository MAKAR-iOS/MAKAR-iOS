//
//  BaseSearchStationViewController.swift
//  MAKAR
//
//  Created by 김다은 on 12/28/23.
//

import UIKit
class BaseSearchStationViewController : BaseViewController {
    
    var dummyList = ["1호선", "2호선", "3호선", "4호선", "5호선", "6호선",
                    "7호선", "8호선", "9호선", "경의중앙", "공항철도", "0호선"]
    let lineNumImage = LineNumImage()
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
        tableView.separatorStyle = .none
        
        tableView.snp.makeConstraints{
            $0.trailing.leading.bottom.equalToSuperview()
        }
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
    }
}

extension BaseSearchStationViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dummyList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "dummyList") ?? UITableViewCell(style: .default, reuseIdentifier: "dummyList")
        let lineNum = dummyList[indexPath.row]
        lineNumImage.addLineNum()
        
        cell.backgroundColor = .background
        cell.textLabel?.text = lineNum
        cell.textLabel?.font = UIFont.systemFont(ofSize: 16)
        cell.textLabel?.textColor = .darkGray
        
        if let lineImage = lineNumImage.lineNumMap[lineNum] {
            cell.accessoryView = UIImageView(image: lineImage)
        } else {
            cell.accessoryView = UIImageView(image: MakarImage.line0)
        }
        return cell
    }
}
