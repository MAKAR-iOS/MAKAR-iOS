//
//  BaseSearchStationViewController.swift
//  MAKAR
//
//  Created by 김다은 on 12/28/23.
//

import UIKit
class BaseSearchStationViewController: BaseViewController {
    
    var dummyList = ["1호선", "2호선", "3호선", "4호선", "5호선", "6호선",
                    "7호선", "8호선", "9호선", "경의중앙", "공항철도", "0호선"]
    var searchList: [StationDTO] = []

    // MARK: UI Components
    let lineNumImage = LineNumImage()
    var tableView = UITableView(frame: .zero, style: .plain)

    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView(data: searchList)
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
    func setTableView(data: [StationDTO]) {
        searchList = data

        view.addSubview(tableView)
        tableView.backgroundColor = .background
        
        tableView.snp.makeConstraints{
            $0.trailing.leading.bottom.equalToSuperview()
        }

        tableView.register(SearchStationTableViewCell.self, forCellReuseIdentifier: "searchStationTableViewCell")
        tableView.dataSource = self
        tableView.delegate = self
    }
}

extension BaseSearchStationViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "searchStationTableViewCell", for: indexPath) as? SearchStationTableViewCell
        else {
            return UITableViewCell()
        }

        let lineNum = searchList[indexPath.row].lineNum
        let stationName = searchList[indexPath.row].stationName

        lineNumImage.addLineNum()

        if let lineImage = lineNumImage.lineNumMap[lineNum] {
            cell.lineNumImageView.image = lineImage
        } else {
            cell.lineNumImageView.image = MakarImage.line0
        }

        cell.stationNameLabel.text = stationName

        return cell
    }
}
