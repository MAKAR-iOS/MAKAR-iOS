//
//  SearchStationViewController.swift
//  MAKAR
//
//  Created by 박지윤 on 2023/12/25.
//

import UIKit

protocol SourceStationProtocol {
    func sendSourceStation(station: StationDTO)
}

class SourceSearchStationViewController: BaseSearchStationViewController {
    // MARK: Constants
    private enum Metric {
        static let viewHeight = 125
    }

    // MARK: UI Components
    private let sourceSearchStationView = SourceSearchStationView()

    private let backButton = BaseButton().then {
        $0.setImage(MakarButton.dismissButton, for: .normal)
    }

    // MARK: Properties
    var searchResult: [StationDTO?] = []
    var sourceStation: StationDTO?
    var sourceDelegate: SourceStationProtocol?
    var homeStation: StationDTO?
    var schoolStation: StationDTO?

    // MARK: Environment
    private let router = BaseRouter()

    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        getFavoriteHome()
        getFavoriteSchool()
        router.viewController = self
        view.backgroundColor = .background
        setSearchBar()
    }

    // MARK: Configuration
    override func configureSubviews() {
        super.configureSubviews()

        view.addSubview(sourceSearchStationView)

        sourceSearchStationView.tapMyLocationButton = {[weak self] in
            guard let self else { return }
            postMyLocationButtonClicked()
        }

        sourceSearchStationView.tapHomeButton = {[weak self] in
            guard let self else { return }

            guard let homeStation = homeStation else { return }
            print("🐶 SourceSearchStationViewController + \(homeStation)")

            sourceDelegate?.sendSourceStation(station: homeStation)
            router.popViewController()
        }

        sourceSearchStationView.tapSchoolButton = { [weak self] in
            guard let self else { return }

            guard let schoolStation = schoolStation else { return }
            print("🐶 SourceSearchStationViewController + \(schoolStation)")

            sourceDelegate?.sendSourceStation(station: schoolStation)
            router.popViewController()
        }

        sourceSearchStationView.tapMoreButton = {[weak self] in
            guard let self else { return }

            router.presentFavoriteStationViewController()
        }
    }

    // MARK: Layout
    override func makeConstraints() {
        super.makeConstraints()

        sourceSearchStationView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(Metric.viewHeight)
        }
    }

    // MARK: Networking
    private func postMyLocationButtonClicked() {
        print("myLocationButton clicked")
    }
    
    private func postHomeButtonClicked() {
        print("homeButton clicked")
    }
    
    private func postSchoolButtonClicked() {
        print("schoolButton clicked")
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
        navigationItem.title = "출발역 입력"
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
    }

    // MARK: TableView
    func setTableView() {
        super.setTableView(data: searchResult)

        searchListTableView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(Metric.viewHeight)
        }
    }
}

extension SourceSearchStationViewController {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)

        guard let sourceStation = searchResult[indexPath.row] else { return }
        print("🐶 SourceSearchStationViewController + \(sourceStation)")

        sourceDelegate?.sendSourceStation(station: sourceStation)
        router.popViewController()
    }
}

extension SourceSearchStationViewController: UISearchBarDelegate {
    func setSearchBar() {
        sourceSearchStationView.stationSearchBar.delegate = self
        sourceSearchStationView.stationSearchBar.showsCancelButton = false
    }

    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        sourceSearchStationView.stationSearchBar.becomeFirstResponder()
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard let station = sourceSearchStationView.stationSearchBar.text else { return }
        getStation(query: station)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        dismissKeyboard()
        guard let station = sourceSearchStationView.stationSearchBar.text else { return }
        getStation(query: station)
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        sourceSearchStationView.stationSearchBar.text = ""
    }

    func dismissKeyboard() {
        sourceSearchStationView.stationSearchBar.resignFirstResponder()
    }
}

// MARK: Networking
extension SourceSearchStationViewController {
    private func getStation(query: String) {
        print("🚇 getStation called")
        NetworkService.shared.station.getStation(query: query) { [self]
            result in
            switch result {
            case .success(let response):
                guard let data = response as? StationResponse else { return }
                print("🎯 getStation success: " + "\(data)")
                searchResult = data.data.stationDtoList
                setTableView()
                searchListTableView.reloadData()
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
    
    private func getFavoriteHome() {
        print("🚇 getFavoriteHome called")
        NetworkService.shared.station.getFavoriteHome() { [self] result in
            switch result {
            case .success(let response):
                guard let data = response as? FavoriteStationGetResponse else { return }
                print("🎯 getFavoriteHome success: " + "\(data)")
                guard let homeStation = data.data else { return }
                self.homeStation = homeStation
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

    private func getFavoriteSchool() {
        print("🚇 getFavoriteSchool called")
        NetworkService.shared.station.getFavoriteSchool() { [self] result in
            switch result {
            case .success(let response):
                guard let data = response as? FavoriteStationGetResponse else { return }
                print("🎯 getFavoriteSchool success: " + "\(data)")
                guard let schoolStation = data.data else { return }
                self.schoolStation = schoolStation
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
