//
//  FavoriteRouteViewController.swift
//  MAKAR
//
//  Created by 김다은 on 1/11/24.
//

import UIKit

class FavoriteRouteViewController: BaseViewController {

    // MARK: UI Components
    let favoriteRouteTableView = UITableView(frame: .zero, style: .plain)

    private let backButton = BaseButton().then {
        $0.setImage(MakarButton.dismissButton, for: .normal)
    }

    // TODO: 최근 경로 리스트 조회 API 연결
    var favoriteRouteList: [BriefRouteDTO]? = []

    // MARK: Environment
    private let router = BaseRouter()

    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .background
        router.viewController = self
        setTableView()
    }

    // MARK: View Transition
    override func viewTransition() {
        backButton.tap = { [weak self] in
            guard let self else { return }
            router.popViewController()
        }
    }

    // MARK: Set Navigation
    override func setNavigationItem() {
        super.setNavigationItem()

        navigationItem.title = "즐겨찾는 경로 설정"
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
    }
}

// MARK: TableView
extension FavoriteRouteViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteRouteList?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "favoriteRouteTableViewCell", for: indexPath) as? FavoriteRouteTableViewCell
        else {
            return UITableViewCell()
        }
        cell.setData(data: favoriteRouteList?[indexPath.row])
        cell.contentView.isHidden = true

        //즐겨찾는 경로 삭제
        cell.tapDeleteRecentRouteButton = {[weak self] in
            guard let self else { return }
            favoriteRouteList?.remove(at: indexPath.row)
            let homeViewController = HomeViewController()
            favoriteRouteList = homeViewController.favoriteRouteList
            favoriteRouteTableView.reloadData()
        }

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let data = favoriteRouteList?[indexPath.row] else { return }
        //searchBar Text 수정
        let sourceText = data.sourceStationName + " " + data.sourceLineNum
        let destinationText = data.destinationStationName + " " + data.destinationLineNum

        let searchRouteVC = SearchRouteViewController()
        searchRouteVC.changeSearchBarText(sourceText: sourceText, destinationText: destinationText)
        self.navigationController?.pushViewController(searchRouteVC, animated: true)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 48
    }
    
    func setTableView() {
        view.addSubview(favoriteRouteTableView)

        favoriteRouteTableView.backgroundColor = .background
        favoriteRouteTableView.separatorStyle = .none
    
        favoriteRouteTableView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.horizontalEdges.bottom.equalToSuperview()
        }

        favoriteRouteTableView.register(FavoriteRouteTableViewCell.self, forCellReuseIdentifier: "favoriteRouteTableViewCell")
        favoriteRouteTableView.dataSource = self
        favoriteRouteTableView.delegate = self
    }
}

