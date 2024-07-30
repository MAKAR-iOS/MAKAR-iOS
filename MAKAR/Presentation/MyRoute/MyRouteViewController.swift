//
//  MyRouteViewController.swift
//  MAKAR
//
//  Created by 박지윤 on 2023/12/25.
//

import UIKit

class MyRouteViewController: BaseViewController {
    // MARK: UI Components
    private let myRouteView = MyRouteView()
    private let myRouteTableView = UITableView(frame: .zero, style: .plain).then {
        $0.allowsSelection = false
    }

    let myRoute: [Route] = Route.myRoute

    // MARK: Environment
    private let router = BaseRouter()

    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setMyRouteTableView()

        router.viewController = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        myRouteTableView.reloadData()
    }

    // MARK: Configuration
    override func configureSubviews() {
        super.configureSubviews()

        view.addSubview(myRouteView)
        view.addSubview(myRouteTableView)
    }

    // MARK: Layout
    override func makeConstraints() {
        super.makeConstraints()

        myRouteView.snp.makeConstraints {
            $0.top.horizontalEdges.equalToSuperview()
            $0.height.equalTo(270)
        }

        myRouteTableView.snp.makeConstraints{
            $0.top.equalTo(myRouteView.snp.bottom)
            $0.horizontalEdges.bottom.equalToSuperview()
        }
    }
}

extension MyRouteViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myRoute[0].subRouteList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "myRouteInfoTableViewCell", for: indexPath) as? MyRouteInfoTableViewCell
        else {
            return UITableViewCell()
        }

        cell.setData(data: myRoute[0].subRouteList[indexPath.row])
        if indexPath.row == myRoute[0].subRouteList.count - 1 {
            cell.dividerView2.isHidden = true
            cell.transferTimeLabel.isHidden = true
            cell.walkVerticalView1.isHidden = true
            cell.walkVerticalView2.isHidden = true
            cell.walkImageView.isHidden = true
        } else {
            cell.walkVerticalView3.isHidden = true
        }

        return cell
    }

    func setMyRouteTableView() {
        myRouteTableView.backgroundColor = .background
        myRouteTableView.separatorStyle = .none

        myRouteTableView.register(MyRouteInfoTableViewCell.self, forCellReuseIdentifier: "myRouteInfoTableViewCell")
        myRouteTableView.dataSource = self
        myRouteTableView.delegate = self
    }
}
