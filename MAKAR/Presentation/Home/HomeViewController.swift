//
//  HomeViewController.swift
//  MAKAR
//
//  Created by 박지윤 on 2023/12/25.
//

import UIKit

class HomeViewController: BaseViewController {
    // MARK: Constants
    private enum Metric {
        static let collectionViewHeight = 100
        static let collectionViewCellHeight = 90
        static let collectionViewCellWidth = 100
    }

    // MARK: Flag
    var isRouteSet = false //경로 설정 유무 플래그
    var isMakarTaken = false

    var sourceStationName: String = ""
    var destinationStationName: String = ""

    var makarNotiList: [NotiData] = [] // 막차 알림 리스트
    var getOffNotiList: [NotiData] = [] // 하차 알림 리스트

    var makarTime: String = "Thu Aug 01 03:50:00 UTC 2024"
    var getOffTime: String = "Fri Aug 01 23:53:00 UTC 2024"

    // MARK: Properties
    var homeData: HomeData?
    var favoriteRouteList: [BriefRouteDTO]? = []
    var recentRouteList: [BriefRouteDTO]? = []

    // MARK: UI Components
    private let homeView = HomeView()
    private let homeScrollView = UIScrollView()
    private let navigationTitleImageView = UIImageView().then {
        $0.image = MakarImage.makarLogo
    }

    lazy var favoriteRouteCollectionView: UICollectionView = {
            let flowLayout = UICollectionViewFlowLayout()
            flowLayout.scrollDirection = .horizontal
            flowLayout.minimumLineSpacing = 15
            //cell 크기 설정
            flowLayout.itemSize = CGSize(width: Metric.collectionViewCellWidth, height: Metric.collectionViewCellHeight)
            let view = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
            return view
        }()
    
    lazy var recentRouteCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 15
        flowLayout.itemSize = CGSize(width: Metric.collectionViewCellWidth, height: Metric.collectionViewCellHeight)
        let view = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        return view
    }()

    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()

        view.backgroundColor = .background
        
        changeComponent()
        setFavoriteRouteCollectionView()
        setRecentRouteCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        getHome()
        getFavoriteRouteList()
        getRecentRouteList()
        startNotification()
        changeComponent()
        favoriteRouteCollectionView.reloadData()
    }

    // MARK: Configuration
    override func configureSubviews() {
        super.configureSubviews()

        view.addSubview(homeScrollView)
        homeScrollView.addSubview(homeView)
        homeScrollView.showsVerticalScrollIndicator = false

        homeView.tapResetRouteButton = { [weak self] in
            guard let self else { return }

            showResetRouteAlert()
            postResetRouteButtonClicked()
        }

        homeView.tapSetRouteButton = { [weak self] in
            guard let self else { return }

            self.navigationController?.pushViewController(SearchRouteViewController(), animated: true)
            // TODO: 경로 설정 API 연결
            postSetRouteButtonClicked()
        }

        homeView.tapChangeRouteButton = { [weak self] in
            guard let self else { return }

            self.navigationController?.pushViewController(SearchRouteViewController(), animated: true)
            postChangeRouteButtonClicked()
        }

        homeView.tapSetAlarmButton = { [weak self] in
            guard let self else { return }

            self.tabBarController?.selectedIndex = 2
            postSetAlarmButtonClicked()
        }

        homeView.tapEditFavoriteRouteButton = { [weak self] in
            guard let self else { return }

            let favoriteRouteViewController = FavoriteRouteViewController()
            self.navigationController?.pushViewController(favoriteRouteViewController, animated: true)
        }

        homeView.tapAllDeleteRecentRouteButton = { [weak self] in
            guard let self else { return }

            deleteAllRecentRoute()
        }
    }

    // MARK: Layout
    override func makeConstraints() {
        super.makeConstraints()

        homeScrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        homeView.snp.makeConstraints {
            $0.width.equalTo(homeScrollView)
            $0.top.bottom.equalTo(homeScrollView)
        }

        navigationTitleImageView.snp.makeConstraints {
            $0.height.equalTo(20)
            $0.width.equalTo(100)
        }

        let contentViewHeight = homeView.heightAnchor.constraint(greaterThanOrEqualTo: view.heightAnchor)
        contentViewHeight.priority = .defaultLow
        contentViewHeight.isActive = true
    }

    // MARK: Networking
    private func postResetRouteButtonClicked() {
        print("resetRouteButton clicked")
    }

    private func postSetRouteButtonClicked() {
        print("setRouteButton clicked")
    }

    private func postChangeRouteButtonClicked() {
        print("changeRouteButton clicked")
    }

    private func postSetAlarmButtonClicked() {
        print("setAlarmButton clicked")
    }

    // MARK: NavigationBar
    private func setNavigationBar() {
        navigationItem.title = nil
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: navigationTitleImageView)
    }

    // MARK: Measure Notification Time
    private func startNotification() {
        DispatchQueue.global(qos: .background).async {
            let runLoop = RunLoop.current
            
            Timer.scheduledTimer(withTimeInterval: 10, repeats: true) { _ in
                if self.isRouteSet {
                    if !self.isMakarTaken {
                        self.handleMakarTime()
                    } else {
                        self.handleGetOffTime()
                    }
                }
            }
            //하차 시간 까지 비동기 루프 실행
            let getOffTimeDate = self.convertStringToDate(targetDateString: self.getOffTime)
            runLoop.run(until: getOffTimeDate)

            //하차 시간 도달
            self.isRouteSet = false
            self.isMakarTaken = false

            //경로 제거
            self.deleteRoute()
            self.changeComponent()
        }
    }

    private func handleMakarTime() {
        let makarLeftTime = self.checkNotificationTime(targetDateString: self.makarTime)
        if makarLeftTime <= 0 {
            // 막차 시간 도달
            self.isMakarTaken = true
            self.changeComponent()
        } else {
            if makarLeftTime == makarNotiList[0].notiMinute {
                addNotification(notiType: "막차", minute: makarLeftTime)
                print("Show MAKAR Notification")
                deleteMakarNoti(notiId: makarNotiList[0].notiId)
            }
            self.changeMainTitleText(target: "막차", minute: makarLeftTime)
        }
    }

    private func handleGetOffTime() {
        let getOffLeftTime = self.checkNotificationTime(targetDateString: self.getOffTime)
        if getOffLeftTime == getOffNotiList[0].notiMinute {
            addNotification(notiType: "하차", minute: getOffLeftTime)
            print("Show GETOFF Notification")
            deleteGetOffNoti(notiId: getOffNotiList[0].notiId)
        }
        self.changeMainTitleText(target: "하차", minute: getOffLeftTime)
    }

    private func convertStringToDate(targetDateString: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEE MMM dd HH:mm:ss Z yyyy"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        
        let adjustedDateString = targetDateString.replacingOccurrences(of: "KST", with: "+0900")
        return dateFormatter.date(from: adjustedDateString)!
    }

    private func checkNotificationTime(targetDateString: String) -> Int {
        let currentDate = Date()
        print("[currentTime] : \(currentDate)")
        // targetDateString을 Date 객체로 변환
        let targetDate = convertStringToDate(targetDateString: targetDateString)

        // 현재 시간과 설정된 시간 분 단위 비교
        return Calendar.current.dateComponents([.minute], from: currentDate, to: targetDate).minute!
    }

    // MARK: ChangeComponent
    private func changeComponent() {
        DispatchQueue.main.async {
            if self.isRouteSet {
                self.updateRouteSetUI()
            } else {
                self.updateRouteUnsetUI()
            }
        }
    }

    private func updateRouteSetUI() {
        if !self.isMakarTaken {
            let makarLeftTime = self.checkNotificationTime(targetDateString: self.makarTime)
            self.changeMainTitleText(target: "막차", minute: makarLeftTime)
            self.homeView.changeMainDestinationText(destinationText: sourceStationName)
        } else {
            let getOffLeftTime = self.checkNotificationTime(targetDateString: self.getOffTime)
            self.changeMainTitleText(target: "하차", minute: getOffLeftTime)
            self.homeView.changeMainDestinationText(destinationText: destinationStationName)
        }
        self.homeView.changeComponentRouteSet(source: sourceStationName, destination: destinationStationName)
        print("changeComponent: RouteSet")
    }

    private func updateRouteUnsetUI(){
        self.homeView.changeComponentRouteUnset()
        self.homeView.changeMainDestinationText(destinationText: "MAKAR")
        print("changeComponent: RouteUnset")
    }

    private func changeMainTitleText(target: String, minute: Int) {
        DispatchQueue.main.async {
            let length = String(minute).count
            let string = "\(target)까지 \(minute)분 남았어요!"
            let formattedText = String(format: NSLocalizedString(string, comment: ""), minute)
            let spannableString = NSMutableAttributedString(string: formattedText)

            spannableString.addAttribute(.foregroundColor, value: UIColor.red, range: NSRange(location: 5, length: length))
            self.homeView.mainTitleText.attributedText = spannableString
        }
    }

    // MARK: Alert
    private func showResetRouteAlert() {
        let resetRouteAlert = UIAlertController(title: "경로 초기화", message: "설정된 경로를 초기화하시겠어요?", preferredStyle: .alert)
        resetRouteAlert.addAction( UIAlertAction(title: "확인", style: .destructive, handler: {_ in
            self.deleteRoute()
        }))
        resetRouteAlert.addAction(UIAlertAction(title: "취소", style: .cancel))
        present(resetRouteAlert, animated: true)
    }

    // MARK: Notification
    private func addNotification(notiType: String, minute: Int) {
        UNUserNotificationCenter.current().addNotificationRequest(notiType: notiType, minute: minute)
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    // MARK: CollectionView
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (collectionView == favoriteRouteCollectionView) {
            return favoriteRouteList?.count ?? 0
        } else {
            return recentRouteList?.count ?? 0
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //즐겨찾는 경로
        if (collectionView == favoriteRouteCollectionView) {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FavoriteRouteCollectionViewCell", for: indexPath) as? FavoriteRouteCollectionViewCell
            else {
                return UICollectionViewCell()
            }
            cell.setData(data: favoriteRouteList?[indexPath.row])
            return cell
        } else {
            //최근 경로
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecentRouteCollectionViewCell", for: indexPath) as? RecentRouteCollectionViewCell
            else {
                return UICollectionViewCell()
            }

            cell.setData(data: recentRouteList?[indexPath.row])

            cell.tapDeleteRecentRouteButton = {[weak self] in
                guard let self else { return }
                guard let routeId = recentRouteList?[indexPath.row].routeId else { return }
                deleteRecentRoute(routeId: routeId)
            }
            return cell
        }
    }

    //item size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if (collectionView == favoriteRouteCollectionView) {
            let data = favoriteRouteList?[indexPath.row]
            let cellWidth = calculateCellWidth(for: data, cell: FavoriteRouteCollectionViewCell())
            return CGSize(width: cellWidth, height: 90)
        } else {
            let data = recentRouteList?[indexPath.row]
            let cellWidth = calculateCellWidth(for: data, cell: RecentRouteCollectionViewCell())
            return CGSize(width: cellWidth, height: 90)
        }
    }

    // TODO: simplify
    private func calculateCellWidth(for data: BriefRouteDTO?, cell: UICollectionViewCell) -> CGFloat {
        if let favoriteCell = cell as? FavoriteRouteCollectionViewCell {
            favoriteCell.setData(data: data)
            favoriteCell.setNeedsLayout()
            favoriteCell.layoutIfNeeded()
            let cellWidth = max(favoriteCell.destinationText.frame.width, favoriteCell.sourceText.frame.width) + 50
            return cellWidth
        } else if let recentCell = cell as? RecentRouteCollectionViewCell {
            recentCell.setData(data: data)
            recentCell.setNeedsLayout()
            recentCell.layoutIfNeeded()
            let cellWidth = max(recentCell.destinationText.frame.width, recentCell.sourceText.frame.width) + 50
            return cellWidth
        } else {
            return 0
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let data: BriefRouteDTO?
        if (collectionView == favoriteRouteCollectionView) {
            data = favoriteRouteList?[indexPath.row]
        } else {
            data = recentRouteList?[indexPath.row]
        }

        guard let data = data else { return }

        let sourceText = "\(data.sourceStationName) \(data.sourceLineNum)"
        let destinationText = "\(data.destinationStationName) \(data.destinationLineNum)"

        let searchRouteViewController = SearchRouteViewController()
        searchRouteViewController.sourceStation = StationDTO(
            stationName: data.sourceStationName,
            lineNum: data.sourceLineNum)
        searchRouteViewController.destinationStation = StationDTO(
            stationName: data.destinationStationName,
            lineNum: data.destinationLineNum)
        searchRouteViewController.changeSearchBarText(sourceText: sourceText, destinationText: destinationText)
        self.navigationController?.pushViewController(searchRouteViewController, animated: true)
    }

    func setFavoriteRouteCollectionView() {
        view.addSubview(favoriteRouteCollectionView)
        favoriteRouteCollectionView.backgroundColor = .background
        favoriteRouteCollectionView.showsHorizontalScrollIndicator = false //스크롤바 숨김

        favoriteRouteCollectionView.snp.makeConstraints {
            $0.top.equalTo(homeView.favoriteRouteListText.snp.bottom).inset(-15)
            $0.leading.equalToSuperview().inset(20)
            $0.trailing.equalToSuperview()
            $0.height.equalTo(Metric.collectionViewHeight)
        }

        favoriteRouteCollectionView.register(FavoriteRouteCollectionViewCell.self, forCellWithReuseIdentifier: "FavoriteRouteCollectionViewCell")
        favoriteRouteCollectionView.delegate = self
        favoriteRouteCollectionView.dataSource = self
    }

    func setRecentRouteCollectionView(){
        homeView.addSubview(recentRouteCollectionView)
        recentRouteCollectionView.showsHorizontalScrollIndicator = false

        recentRouteCollectionView.snp.makeConstraints {
            $0.top.equalTo(homeView.recentRouteListText.snp.bottom).inset(-15)
            $0.leading.equalToSuperview().inset(20)
            $0.trailing.equalToSuperview()
            $0.height.equalTo(Metric.collectionViewHeight)
            $0.bottom.equalToSuperview().inset(30)
        }

        recentRouteCollectionView.register(RecentRouteCollectionViewCell.self, forCellWithReuseIdentifier: "RecentRouteCollectionViewCell")
        recentRouteCollectionView.delegate = self
        recentRouteCollectionView.dataSource = self
    }
}

// MARK: Networking
extension HomeViewController {
    private func getHome() {
        print("🏠 getHome called")
        NetworkService.shared.home.getHome() {
            [self] result in
            switch result {
            case .success(let response):
                guard let data = response as? HomeResponse else { return }
                print("🎯 getHome success: " + "\(data)")
                isRouteSet = data.data.routeSet
                if isRouteSet {
                    guard let sourceStationName = data.data.sourceStationName,
                          let destinationStationName = data.data.destinationStationName,
                          let makarTime = data.data.makarTime,
                          let getOffTime = data.data.getOffTime,
                          let makarNotiList = data.data.makarNotiList,
                          let getOffNotiList = data.data.getOffNotiList
                    else { return }
                    self.sourceStationName = sourceStationName
                    self.destinationStationName = destinationStationName
                    self.makarTime = makarTime
                    self.getOffTime = getOffTime
                    self.makarNotiList = makarNotiList
                    self.getOffNotiList = getOffNotiList
                }
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
    
    private func deleteRoute() {
        print("🚇 deleteRoute called")
        NetworkService.shared.route.deleteRoute {
            [self] result in
            switch result {
            case .success(let response):
                guard let data = response as? RouteListResponse else { return }
                print("🎯 deleteRoute success: " + "\(data)")
                UserDefaultHandler.routeId = 0
                isRouteSet = false
                isMakarTaken = false
                changeComponent()
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

    private func getFavoriteRouteList() {
        print("🚇 getFavoriteRouteList called")
        NetworkService.shared.route.getFavoriteRouteList() {
            [self] result in
            switch result {
            case .success(let response):
                guard let data = response as? FavoriteRouteListResponse else { return }
                print("🎯 getFavoriteRouteList success: " + "\(data)")
                favoriteRouteList = data.data
                favoriteRouteCollectionView.reloadData()
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

    private func deleteRecentRoute(routeId: Int) {
        print("🚇 deleteRecentRoute called")
        NetworkService.shared.route.deleteRecentRoute(routeId: routeId) {
            [self] result in
            switch result {
            case .success(let response):
                guard let data = response as? DeleteRouteListResponse else { return }
                print("🎯 deleteRecentRoute success: " + "\(data)")
                getRecentRouteList()
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

    private func deleteAllRecentRoute() {
        print("🚇 deleteAllRecentRoute called")
        NetworkService.shared.route.deleteAllRecentRoute() {
            [self] result in
            switch result {
            case .success(let response):
                guard let data = response as? DeleteRouteListResponse else { return }
                print("🎯 deleteAllRecentRoute success: " + "\(data)")
                getRecentRouteList()
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

    private func getRecentRouteList() {
        print("🚇 getRecentRouteList called")
        NetworkService.shared.route.getRecentRouteList() {
            [self] result in
            switch result {
            case .success(let response):
                guard let data = response as? RecentRouteListResponse else { return }
                print("🎯 getRecentRouteList success: " + "\(data)")
                recentRouteList = data.data.recentRouteList
                recentRouteCollectionView.reloadData()
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

    private func deleteMakarNoti(notiId: Int) {
        print("🔔 deleteMakarNoti called")
        NetworkService.shared.noti.deleteMakarNoti(notiId: notiId) {
            [self] result in
            switch result {
            case .success(let response):
                guard let data = response as? NotiListResponse else { return }
                print("🎯 notiMakarNoti success: " + "\(data)")
                makarNotiList = data.data.makarNotiDtoList
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

    private func deleteGetOffNoti(notiId: Int) {
        print("🔔 deleteGetOffNoti called")
        NetworkService.shared.noti.deleteMakarNoti(notiId: notiId){
            [self] result in
            switch result {
            case .success(let response):
                guard let data = response as? NotiListResponse else { return }
                print("🎯 notiGetOffNoti success: " + "\(data)")
                getOffNotiList = data.data.getoffNotiDtoList
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

