//
//  DestinationSearchStationViewController.swift
//  MAKAR
//
//  Created by 김다은 on 12/27/23.
//

import UIKit
class DestinationSearchStationViewController: BaseSearchStationViewController {
    // MARK: Constants
    private enum Metric {
        static let viewHeight = 125
    }

    // MARK: UI Components
    private let destinationSearchStationView = DestinationSearchStationView()

    private let backButton = BaseButton().then {
        $0.setImage(MakarButton.dismissButton, for: .normal)
    }

    // MARK: Properties
    var isFiltering: Bool = false
    var searchResult: [StationDTO] = []
    var destinationStation: StationDTO?

    // MARK: Environment
    private let router = BaseRouter()

    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        router.viewController = self
        view.backgroundColor = .background
        setSearchBar()
        getStation(query: "오")
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
    private func postHomeButtonClicked() {
        print("homeButton clicked")
    }
    
    private func postSchoolButtonClicked() {
        print("schoolButton clicked")
    }
    
    private func postMoreButtonClicked() {
        print("moreButton clicked")
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
        navigationItem.title = "도착역 입력"
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
    }

    // MARK: TableView
    func setTableView() {
        super.setTableView(data: searchResult)

        tableView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(Metric.viewHeight)
        }
    }
}

extension DestinationSearchStationViewController {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)

        destinationStation = searchResult[indexPath.row]
        let searchRouteViewController = SearchRouteViewController()
        searchRouteViewController.getDestinationStationData(destinationStation)

        router.popViewController()
    }
}

extension DestinationSearchStationViewController: UISearchBarDelegate {
    func setSearchBar() {
        destinationSearchStationView.stationSearchBar.delegate = self
        destinationSearchStationView.stationSearchBar.showsCancelButton = false
    }

    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        isFiltering = true
        tableView.reloadData()
        print("searchBarTextDidBeginEditing")
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard let text = destinationSearchStationView.stationSearchBar.text else { return }

        tableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        dismissKeyboard()
        guard let station = destinationSearchStationView.stationSearchBar.text else { return }

//        getStation(query: station)
//        print("searchBarSearchButtonClicked")

        self.tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.destinationSearchStationView.stationSearchBar.text = ""
        self.destinationSearchStationView.stationSearchBar.resignFirstResponder()
        self.isFiltering = false
        self.tableView.reloadData()
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        self.tableView.reloadData()
    }
    
    func dismissKeyboard() {
        self.destinationSearchStationView.stationSearchBar.resignFirstResponder()
    }
}

// MARK: Networking
extension DestinationSearchStationViewController {
    private func getStation(query: String) {
        print("🚇 getStation called")
        NetworkService.shared.station.getStation(query: query) {
            result in
                switch result {
                case .success(let response):
                    guard let data = response as? StationResponse else { return }
                    print("🎯 getStation success: " + "\(data)")
                    self.searchResult = data.data.stationDtoList
                    self.setTableView()
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
