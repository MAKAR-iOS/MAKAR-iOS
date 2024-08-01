//
//  SearchRouteViewController.swift
//  MAKAR
//
//  Created by 박지윤 on 2023/12/25.
//

import UIKit

class SearchRouteViewController: BaseViewController, SourceStationProtocol, DestinationStationProtocol {

    // MARK: UI Components
    private let searchRouteView = SearchRouteView()
    private let searchRouteTableView = UITableView(frame: .zero, style: .plain)
    private let emptyResultView = EmptyResultView("검색된 경로가 없습니다.")
    private let backButton = BaseButton().then {
        $0.setImage(MakarButton.dismissButton, for: .normal)
    }

    // MARK: Properties
    var sourceStation: StationDTO?
    var destinationStation: StationDTO?
    var searchRouteResultList: [RouteDTO] = []

    // MARK: Environment
    private let router = BaseRouter()

    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .background
        router.viewController = self
        setSearchRouteTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setSourceSearch()
        setDestinationSearch()
     }
    
    // MARK: Configuration
    override func configureSubviews() {
        super.configureSubviews()
        
        view.addSubview(searchRouteView)
        view.addSubview(searchRouteTableView)
        view.addSubview(emptyResultView)

        searchRouteView.tapSwapStationButton = {[weak self] in
            guard let self else { return }
        }

        searchRouteView.tapSourceSearchBar = {[weak self] in
            guard let self = self else { return }

            let sourceSearchStationViewController = SourceSearchStationViewController()
            sourceSearchStationViewController.sourceDelegate = self
            self.navigationController?.pushViewController(sourceSearchStationViewController, animated: true)
        }

        searchRouteView.tapDestinationSearchBar = {[weak self] in
            guard let self else { return }
            
            let destinationSearchStationViewController = DestinationSearchStationViewController()
            destinationSearchStationViewController.destinationDelegate = self
            self.navigationController?.pushViewController(destinationSearchStationViewController, animated: true)
        }
        
        searchRouteView.tapSearchRouteButton = { [self] in
            guard let fromStationName = sourceStation?.stationName else { return }
            guard let fromLineNum = sourceStation?.lineNum else { return }
            guard let toStationName = destinationStation?.stationName else { return }
            guard let toLineNum = destinationStation?.lineNum else { return }
            
            getRouteList(fromStationName: fromStationName,
                         fromLineNum: fromLineNum,
                         toStationName: toStationName,
                         toLineNum: toLineNum)
        }
    }
    
    // MARK: Layout
    override func makeConstraints() {
        super.makeConstraints()
        
        searchRouteView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(Metric.searchRouteViewHeight)
        }

        searchRouteTableView.snp.makeConstraints {
            $0.top.equalTo(searchRouteView.snp.bottom)
            $0.horizontalEdges.bottom.equalToSuperview()
        }

        emptyResultView.snp.makeConstraints {
            $0.top.equalTo(searchRouteView.snp.bottom)
            $0.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
        }
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

        navigationItem.title = "경로 설정하기"
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
    }

    // MARK: Event
    func changeSearchBarText(sourceText: String, destinationText: String) {
        self.searchRouteView.changeSearchBarText(sourceText: sourceText, destinationText: destinationText)
    }

    func setSourceSearch() {
        guard let sourceStation = sourceStation else { return }
        let sourceSearchBarTitle = "\(sourceStation.stationName) \(sourceStation.lineNum)"
        searchRouteView.sourceSearchBar.setTitle(sourceSearchBarTitle, for: .normal)
    }

    func setDestinationSearch() {
        guard let destinationStation = destinationStation else { return }
        let destinationSearchBarTitle = "\(destinationStation.stationName) \(destinationStation.lineNum)"
        searchRouteView.destinationSearchBar.setTitle(destinationSearchBarTitle, for: .normal)
    }
}

extension SearchRouteViewController {
    func sendSourceStation(station: StationDTO) {
        self.sourceStation = station
        print("🥺: \(String(describing: self.sourceStation))")
        print("🥺: \(String(describing: self.destinationStation))")
    }

    func sendDestinationStation(station: StationDTO) {
        self.destinationStation = station
        print("🧚‍♀️: \(String(describing: self.sourceStation))")
        print("🧚‍♀️: \(String(describing: self.destinationStation))")
    }
}

extension SearchRouteViewController {
    // MARK: Networking
    private func getRouteList(fromStationName: String,
                              fromLineNum: String,
                              toStationName: String,
                              toLineNum: String) {
        print("🚇 getRouteList called")
        NetworkService.shared.route.getRouteList(
            fromStationName: fromStationName,
            fromLineNum: fromLineNum,
            toStationName: toStationName,
            toLineNum: toLineNum
        ) { [self] result in
            switch result {
            case .success(let response):
                guard let data = response as? RouteListResponse else { return }
                print("🎯 getRouteList success: " + "\(data)")
                searchRouteResultList = data.data.routeDtoList
                searchRouteTableView.reloadData()
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
            }
        }
    }
}

// MARK: TableView
extension SearchRouteViewController {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)

        let route = searchRouteResultList[indexPath.row]
        let routeId = route.routeId

        postRoute(routeId: routeId)
        self.navigationController?.popToRootViewController(animated: true)
    }
}

extension SearchRouteViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        searchRouteTableView.isHidden = searchRouteResultList.isEmpty
        emptyResultView.isHidden = !searchRouteResultList.isEmpty
        return searchRouteResultList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "searchRouteTableViewCell", for: indexPath) as? SearchRouteTableViewCell
        else {
            return UITableViewCell()
        }

        cell.setData(data: searchRouteResultList[indexPath.row])
        cell.tapFavoriteRouteButton = { [weak self] in
            guard let self else { return }
            let routeId = searchRouteResultList[indexPath.row].routeId
            postFavoriteRoute(routeId: routeId)
        }
        return cell
    }
    
    func setSearchRouteTableView() {
        searchRouteTableView.backgroundColor = .background
        searchRouteTableView.separatorStyle = .singleLine
        searchRouteTableView.rowHeight = UITableView.automaticDimension

        searchRouteTableView.register(SearchRouteTableViewCell.self, forCellReuseIdentifier: "searchRouteTableViewCell")
        searchRouteTableView.dataSource = self
        searchRouteTableView.delegate = self
    }
}

// MARK: Networking
extension SearchRouteViewController {
    private func postRoute(routeId: Int) {
        print("🚇 postRoute called")
        NetworkService.shared.route.postRoute(routeId: routeId) { [self]
            result in
                switch result {
                case .success(let response):
                    guard let data = response as? RouteSetResponse else { return }
                    print("🎯 postRoute success: " + "\(data)")
                    router.popViewController()
                case .requestErr(let errorResponse):
                    dump(errorResponse)
                    guard let data = errorResponse as? ErrorResponse else { return }
                    print(data)
                    print("requestErr")
                case .serverErr:
                    print("serverErr")
                case .networkFail:
                    print("networkFail")
                case .pathErr:
                    print("pathErr")
                }
        }
    }

    private func postFavoriteRoute(routeId: Int) {
        print("🚇 postFavoriteRoute called")
        NetworkService.shared.route.postFavoriteRoute(routeId: routeId) { [self]
            result in
                switch result {
                case .success(let response):
                    guard let data = response as? FavoriteRoutePostListResponse else { return }
                    print("🎯 postFavoriteRoute success: " + "\(data)")
                case .requestErr(let errorResponse):
                    dump(errorResponse)
                    guard let data = errorResponse as? ErrorResponse else { return }
                    print(data)
                    print("requestErr")
                case .serverErr:
                    print("serverErr")
                case .networkFail:
                    print("networkFail")
                case .pathErr:
                    print("pathErr")
                }
        }
    }
}
