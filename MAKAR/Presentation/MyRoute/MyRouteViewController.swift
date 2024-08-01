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
    private let emptyResultView = EmptyResultView("설정된 경로가 없습니다.").then {
        $0.isHidden = true
    }

    var myRoute: RouteGetDTO?

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
        getRoute()
    }

    // MARK: Configuration
    override func configureSubviews() {
        super.configureSubviews()

        view.addSubview(myRouteView)
        view.addSubview(myRouteTableView)
        view.addSubview(emptyResultView)
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

        emptyResultView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

extension MyRouteViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myRoute?.subRouteDtoList.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "myRouteInfoTableViewCell", for: indexPath) as? MyRouteInfoTableViewCell
        else {
            return UITableViewCell()
        }

        cell.setData(data: myRoute?.subRouteDtoList[indexPath.row])

        if !(myRoute?.subRouteDtoList.isEmpty)! {
            if indexPath.row == (myRoute?.subRouteDtoList.count)! - 1 {
                cell.dividerView2.isHidden = true
                cell.transferTimeLabel.isHidden = true
                cell.walkVerticalView1.isHidden = true
                cell.walkVerticalView2.isHidden = true
                cell.walkImageView.isHidden = true
            } else {
                cell.walkVerticalView3.isHidden = true
            }
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

    func setHidden(_ bool: Bool) {
        myRouteTableView.isEditing = bool
        myRouteView.isHidden = bool
        emptyResultView.isHidden = !bool
    }
}

extension MyRouteViewController {
    // MARK: Networking
    private func getRoute() {
        print("🚇 getRoute called")
        NetworkService.shared.route.getRoute() {
            [self] result in
            switch result {
            case .success(let response):
                guard let data = response as? RouteGetResponse else { return }
                print("🎯 getRoute success: " + "\(data)")
                setHidden(false)
                myRoute = data.data
                myRouteTableView.reloadData()
                myRouteView.setData(data: myRoute)
            case .requestErr(let errorResponse):
                dump(errorResponse)
                guard let data = errorResponse as? ErrorResponse else { return }
                print(data)
            case .serverErr:
                print("serverErr")
            case .networkFail:
                print("networkFail")
            case .pathErr:
                print("pathErr")
                setHidden(true)
            }
        }
    }
}
