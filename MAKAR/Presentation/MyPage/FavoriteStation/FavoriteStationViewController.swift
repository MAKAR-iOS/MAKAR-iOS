//
//  FavoriteStationViewController.swift
//  MAKAR
//
//  Created by 김다은 on 12/28/23.
//

import UIKit

class FavoriteStationViewController : BaseViewController, HomeStationProtocol, SchoolStationProtocol {
    // MARK: UI Components
    private let favoriteStationView = FavoriteStationView()
    
    private let backButton = BaseButton().then {
        $0.setImage(MakarButton.dismissButton, for: .normal)
    }

    // MARK: Properties
    var homeStation: StationDTO?
    var schoolStation: StationDTO?

    // MARK: Environment
    private let router = BaseRouter()

    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .background
        router.viewController = self
    }

    // MARK: Configuration
    override func configureSubviews() {
        super.configureSubviews()

        view.addSubview(favoriteStationView)

        favoriteStationView.tapHomeSearchStationButton = {[weak self] in
            guard let self else { return }

            let homeSearchStationViewController = HomeSearchStationViewController()
            homeSearchStationViewController.homeDelegate = self
            navigationController?.pushViewController(homeSearchStationViewController, animated: true)
        }

        favoriteStationView.tapSchoolSearchStationButton = {[weak self] in
            guard let self else { return }

            let schoolSearchStationViewController = SchoolSearchStationViewController()
            schoolSearchStationViewController.schoolDelegate = self
            navigationController?.pushViewController(schoolSearchStationViewController, animated: true)
        }

        favoriteStationView.tapSetButton = {[weak self] in
            guard let self else { return }
            guard let homeStationName = homeStation?.stationName else { return }
            guard let homeLineNum = homeStation?.lineNum else { return }
            guard let schoolStationName = schoolStation?.stationName else { return }
            guard let schoolLineNum = schoolStation?.lineNum else { return }

            patchFavoriteHome(stationName: homeStationName, lineNum: homeLineNum)
            patchFavoriteSchool(stationName: schoolStationName, lineNum: schoolLineNum)
        }
    }

    // MARK: Layout
    override func makeConstraints() {
        super.makeConstraints()

        favoriteStationView.snp.makeConstraints {
            $0.edges.equalToSuperview()
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

        navigationItem.title = "자주 가는 역 설정"
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
    }
}

extension FavoriteStationViewController {
    func sendHomeStation(station: StationDTO) {
        self.homeStation = station
        print("🥺: \(String(describing: self.homeStation))")
        print("🥺: \(String(describing: self.schoolStation))")
    }

    func sendSchoolStation(station: StationDTO) {
        self.schoolStation = station
        print("🧚‍♀️: \(String(describing: self.homeStation))")
        print("🧚‍♀️: \(String(describing: self.schoolStation))")
    }
}

extension FavoriteStationViewController {
    // MARK: Networking
    private func patchFavoriteHome(stationName: String, lineNum: String) {
        print("🚇 patchFavoriteHome called")
        NetworkService.shared.station.patchFavoriteHome(
            stationName: stationName,
            lineNum: lineNum
        ) { result in
            switch result {
            case .success(let response):
                guard let data = response as? FavoriteStationResponse else { return }
                print("🎯 patchFavoriteHome success: " + "\(data)")
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

    private func patchFavoriteSchool(stationName: String, lineNum: String) {
        print("🚇 patchFavoriteSchool called")
        NetworkService.shared.station.patchFavoriteSchool(
            stationName: stationName,
            lineNum: lineNum
        ) { [self] result in
            switch result {
            case .success(let response):
                guard let data = response as? FavoriteStationResponse else { return }
                print("🎯 patchFavoriteSchool success: " + "\(data)")
                router.popViewController()
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
