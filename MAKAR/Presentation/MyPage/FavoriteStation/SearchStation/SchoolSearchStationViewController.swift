//
//  SchoolSearchStationViewController.swift
//  MAKAR
//
//  Created by 김다은 on 12/28/23.
//

import UIKit
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
    var isFiltering: Bool = false
    var searchResult: [StationDTO] = []
    var schoolStation: StationDTO?

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
        
        view.addSubview(schoolSearchStationView)
    }
    
    // MARK: Layout
    override func makeConstraints() {
        super.makeConstraints()
        
        schoolSearchStationView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
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

        tableView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(Metric.viewHeight)
        }
    }
}

extension SchoolSearchStationViewController {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)

        schoolStation = searchResult[indexPath.row]
        let favoriteStationViewController = FavoriteStationViewController()
        favoriteStationViewController.getSchoolStationData(schoolStation)

        router.popViewController()
    }
}

extension SchoolSearchStationViewController: UISearchBarDelegate {
    func setSearchBar() {
        schoolSearchStationView.stationSearchBar.delegate = self
        schoolSearchStationView.stationSearchBar.showsCancelButton = false
    }

    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        isFiltering = true
        tableView.reloadData()
        print("searchBarTextDidBeginEditing")
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard let text = schoolSearchStationView.stationSearchBar.text else { return }

        tableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        dismissKeyboard()
        guard let station = schoolSearchStationView.stationSearchBar.text else { return }

//        getStation(query: station)
//        print("searchBarSearchButtonClicked")

        self.tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.schoolSearchStationView.stationSearchBar.text = ""
        self.schoolSearchStationView.stationSearchBar.resignFirstResponder()
        self.isFiltering = false
        self.tableView.reloadData()
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        self.tableView.reloadData()
    }
    
    func dismissKeyboard() {
        self.schoolSearchStationView.stationSearchBar.resignFirstResponder()
    }
}

// MARK: Networking
extension SchoolSearchStationViewController {
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
