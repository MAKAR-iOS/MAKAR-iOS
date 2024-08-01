//
//  DestinationSearchStationViewController.swift
//  MAKAR
//
//  Created by 김다은 on 12/27/23.
//

import UIKit

protocol DestinationStationProtocol {
    func sendDestinationStation(station: StationDTO)
}

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
    var searchResult: [StationDTO?] = []
    var destinationStation: StationDTO?
    var destinationDelegate: DestinationStationProtocol?

    // MARK: Environment
    private let router = BaseRouter()

    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        router.viewController = self
        view.backgroundColor = .background
        setSearchBar()
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

        searchListTableView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(Metric.viewHeight)
        }
    }
}

extension DestinationSearchStationViewController {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)

        guard let destinationStation = searchResult[indexPath.row] else { return }

        let searchRouteViewController = SearchRouteViewController()
        print("🐶 DestinationSearchStationViewController + \(destinationStation)")

        destinationDelegate?.sendDestinationStation(station: destinationStation)

        router.popViewController()
    }
}

extension DestinationSearchStationViewController: UISearchBarDelegate {
    func setSearchBar() {
        destinationSearchStationView.stationSearchBar.delegate = self
        destinationSearchStationView.stationSearchBar.showsCancelButton = false
    }

    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        destinationSearchStationView.stationSearchBar.becomeFirstResponder()
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard let station = destinationSearchStationView.stationSearchBar.text else { return }
        getStation(query: station)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        dismissKeyboard()
        guard let station = destinationSearchStationView.stationSearchBar.text else { return }
        getStation(query: station)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        destinationSearchStationView.stationSearchBar.text = ""
    }

    func dismissKeyboard() {
        destinationSearchStationView.stationSearchBar.resignFirstResponder()
    }
}

// MARK: Networking
extension DestinationSearchStationViewController {
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
}
