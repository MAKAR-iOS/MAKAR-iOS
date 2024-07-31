//
//  SchoolSearchStationViewController.swift
//  MAKAR
//
//  Created by 김다은 on 12/28/23.
//

import UIKit

protocol SchoolStationProtocol {
    func sendSchoolStation(station: StationDTO)
}

class SchoolSearchStationViewController: BaseSearchStationViewController {
    // MARK: Constants
    private enum Metric {
        static let viewHeight = 80
    }

    // MARK: UI Components
    private let schoolSearchStationView = SchoolSearchStationView()

    private let backButton = BaseButton().then {
        $0.setImage(MakarButton.dismissButton, for: .normal)
    }

    // MARK: Properties
    var searchResult: [StationDTO?] = []
    var schoolStation: StationDTO?
    var schoolDelegate: SchoolStationProtocol?

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

        view.addSubview(schoolSearchStationView)
    }

    // MARK: Layout
    override func makeConstraints() {
        super.makeConstraints()

        schoolSearchStationView.snp.makeConstraints {
            $0.top.horizontalEdges.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(Metric.viewHeight)
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
        navigationItem.title = "역 검색"
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

extension SchoolSearchStationViewController {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)

        guard let schoolStation = searchResult[indexPath.row] else { return }
        print("🐶 SchoolSearchStationViewController + \(schoolStation)")

        schoolDelegate?.sendSchoolStation(station: schoolStation)
        router.popViewController()
    }
}

extension SchoolSearchStationViewController: UISearchBarDelegate {
    func setSearchBar() {
        schoolSearchStationView.stationSearchBar.delegate = self
        schoolSearchStationView.stationSearchBar.showsCancelButton = false
    }

    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        schoolSearchStationView.stationSearchBar.becomeFirstResponder()

    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard let station = schoolSearchStationView.stationSearchBar.text else { return }
        getStation(query: station)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        dismissKeyboard()
        guard let station = schoolSearchStationView.stationSearchBar.text else { return }
        getStation(query: station)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        schoolSearchStationView.stationSearchBar.text = ""
    }

    func dismissKeyboard() {
        schoolSearchStationView.stationSearchBar.resignFirstResponder()
    }
}

// MARK: Networking
extension SchoolSearchStationViewController {
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
