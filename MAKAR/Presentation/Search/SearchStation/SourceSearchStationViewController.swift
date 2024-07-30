//
//  SearchStationViewController.swift
//  MAKAR
//
//  Created by 박지윤 on 2023/12/25.
//

import UIKit

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
    var isFiltering: Bool = false

    // MARK: Environment
    private let router = BaseRouter()

    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        router.viewController = self
        view.backgroundColor = .background
        setSearchBar()
        getStation(query: "숭실대")
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

            navigationController?.popViewController(animated: true)
            postHomeButtonClicked()
        }

        sourceSearchStationView.tapSchoolButton = {[weak self] in
            guard let self else { return }

            navigationController?.popViewController(animated: true)
            postSchoolButtonClicked()
        }

        sourceSearchStationView.tapMoreButton = {[weak self] in
            guard let self else { return }

            self.navigationController?.pushViewController(FavoriteStationViewController(), animated: true)
            postMoreButtonClicked()
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
    private func postMyLocationButtonClicked(){
        print("myLocationButton clicked")
    }
    
    private func postHomeButtonClicked(){
        print("homeButton clicked")
    }
    
    private func postSchoolButtonClicked(){
        print("schoolButton clicked")
    }
    
    private func postMoreButtonClicked(){
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
        navigationItem.title = "출발역 입력"
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
    }

    // MARK: TableView
    override func setTableView() {
        super.setTableView()
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(Metric.viewHeight)
        }
    }
}

extension SourceSearchStationViewController {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        // TODO: 출발역 등록
        navigationController?.popViewController(animated: true)
    }
}

//extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
//    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // 서치바를 통해 무언가 검색했다면 filterredArr의 갯수로, 그렇지 않다면 arr의 갯수로
//        return self.isFilterting ? self.filterredArr.count : self.arr.count
//    }
//
//    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "SeachListCell") as! SearchListTableViewCell
//        if self.isFiltering {
//            cell.textLabel?.text = self.filterredArr[indexPath.row]
//        } else {
//            cell.textLabel?.text = self.arr[indexPath.row]
//        }
//
//        return cell
//    }
//}
//

extension SourceSearchStationViewController: UISearchBarDelegate {
    // 서치바에서 검색을 시작할 때 호출
    func setSearchBar() {
        sourceSearchStationView.stationSearchBar.delegate = self
        sourceSearchStationView.stationSearchBar.showsCancelButton = false
    }

    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        isFiltering = true
        tableView.reloadData()
        print("searchBarTextDidBeginEditing")
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard let text = sourceSearchStationView.stationSearchBar.text else { return }
//        self.filterredArr = self.arr.filter { $0.localizedCaseInsensitiveContains(text) }
       
        tableView.reloadData()
    }
    
    // 서치바에서 검색버튼을 눌렀을 때 호출
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        dismissKeyboard()
        guard let text = sourceSearchStationView.stationSearchBar.text?.lowercased() else { return }
//        self.filterredArr = self.arr.filter { $0.localizedCaseInsensitiveContains(text) }
        print("searchBarSearchButtonClicked")

        self.tableView.reloadData()
    }
    
    // 서치바에서 취소 버튼을 눌렀을 때 호출
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.sourceSearchStationView.stationSearchBar.text = ""
        self.sourceSearchStationView.stationSearchBar.resignFirstResponder()
        self.isFiltering = false
        self.tableView.reloadData()
    }
    
    // 서치바 검색이 끝났을 때 호출
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        self.tableView.reloadData()
    }
    
    // 서치바 키보드 내리기
    func dismissKeyboard() {
        self.sourceSearchStationView.stationSearchBar.resignFirstResponder()
    }
}

// MARK: Networking
extension SourceSearchStationViewController {
    private func getStation(query: String) {
        print("🚇 getStation called")
        NetworkService.shared.station.getStation(query: query) {
            result in
                switch result {
                case .success(let response):
                    guard let data = response as? AuthResponse else { return }
                    print("🎯 getStation success: " + "\(data)")
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
