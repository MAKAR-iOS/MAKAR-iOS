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
    static var isRouteSet = false //경로 설정 유무 플래그
    static var isMakarTaken = false
    
    let sourceStationName = "숭실대입구"
    let destinationStationName = "영등포"
    
    var makarNotiList : [Noti] = Noti.makarNotiList // 막차 알림 리스트
    var getOffNotiList : [Noti] = Noti.getOffNotiList // 하차 알림 리스트
    
    let makarTime = "Tue Jul 30 14:50:00 KST 2024"
    let getOffTime = "Tue Jul 30 14:53:00 KST 2024"
    
    
    // TODO: 최근 경로 리스트, 즐겨찾는 경로 리스트 조회 API 연결
    static var favoriteRouteList : [Route] = Route.favoriteRouteList
    var recentRouteList : [Route] = Route.recentRouteList
    
    // MARK: UI Components
    private let homeView = HomeView()
    private let homeScrollView = UIScrollView()
    
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
        
        homeView.tapResetRouteButton = {[weak self] in
            guard let self else { return }
            
            showResetRouteAlert()
            postResetRouteButtonClicked()
        }
        
        homeView.tapSetRouteButton = {[weak self] in
            guard let self else { return }
            
            self.navigationController?.pushViewController(SearchRouteViewController(), animated: true)
            // TODO: flag 수정
            HomeViewController.isRouteSet = true;
            postSetRouteButtonClicked()
        }
        
        homeView.tapChangeRouteButton = {[weak self] in
            guard let self else { return }
            
            self.navigationController?.pushViewController(SearchRouteViewController(), animated: true)
            postChangeRouteButtonClicked()
        }
        
        homeView.tapSetAlarmButton = {[weak self] in
            guard let self else { return }
            
            self.tabBarController?.selectedIndex = 3
            postSetAlarmButtonClicked()
        }
        
        homeView.tapEditFavoriteRouteButton = {[weak self] in
            guard let self else { return }
            
            self.navigationController?.pushViewController(FavoriteRouteViewController(), animated: true)
        }
        
        homeView.tapAllDeleteRecentRouteButton = {[weak self] in
            guard let self else { return }
            
            self.recentRouteList = []
            recentRouteCollectionView.reloadData()
        }
    }
    
    // MARK: Layout
    override func makeConstraints() {
        super.makeConstraints()
        
        homeScrollView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        homeView.snp.makeConstraints{
            $0.width.equalTo(homeScrollView)
            $0.top.bottom.equalTo(homeScrollView)
        }
        
        let contentViewHeight = homeView.heightAnchor.constraint(greaterThanOrEqualTo: view.heightAnchor)
        contentViewHeight.priority = .defaultLow
        contentViewHeight.isActive = true
    }
    
    // MARK: Networking
    private func postResetRouteButtonClicked(){
        print("resetRouteButton clicked")
    }
    
    private func postSetRouteButtonClicked() {
        print("setRouteButton clicked")
    }
    
    private func postMapButtonClicked(){
        print("mapButton clicked")
    }
    
    private func postChangeRouteButtonClicked(){
        print("changeRouteButton clicked")
    }
    
    private func postSetAlarmButtonClicked(){
        print("setAlarmButton clicked")
    }
    
    // MARK: NavigationBar
    private func setNavigationBar(){
        navigationItem.title = nil
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: MakarButton.mapButton, style: .plain, target: self, action: #selector(handleMapButtonClickEvent))
    }
    
    @objc private func handleMapButtonClickEvent(){
        postMapButtonClicked()
    }
    
    // MARK: Measure Notification Time
    private func startNotification(){
        DispatchQueue.global(qos: .background).async {
            let runLoop = RunLoop.current
            
            Timer.scheduledTimer(withTimeInterval: 10, repeats: true){ _ in
                if HomeViewController.isRouteSet {
                    if !HomeViewController.isMakarTaken {
                        self.handleMakarTime()
                    } else {
                        self.handleGetOffTime()
                    }
                }
            }
            //하차 시간 까지 비동기 루프 실행
            let getOffTimeDate = self.convertStringToDate(targetDateString: self.getOffTime)
            print("getOffTimeDate = \(getOffTimeDate)")
            runLoop.run(until: getOffTimeDate)
            
            //하차 시간 도달
            HomeViewController.isRouteSet = false
            HomeViewController.isMakarTaken = false

            //경로 제거
            // TODO: 설정된 경로 삭제 API 연결
            self.changeComponent()
        }
    }
    
    private func handleMakarTime() {
        let makarLeftTime = self.checkNotificationTime(targetDateString: self.makarTime)
        if makarLeftTime < 0 {
            // 막차 시간 도달
            HomeViewController.isMakarTaken = true
            self.changeComponent()
        } else {
            for makarNoti in makarNotiList {
                if makarLeftTime == makarNoti.notiMinute {
                    // TODO: showNotification
                    print("Show Makar Noti")
                    // 해당 데이터 제거
                }
            }
            self.changeMainTitleText(target: "막차", minute: makarLeftTime)
        }
    }

    private func handleGetOffTime() {
        let getOffLeftTime = self.checkNotificationTime(targetDateString: self.getOffTime)
        for getOffNoti in getOffNotiList {
            if getOffLeftTime == getOffNoti.notiMinute {
                // TODO: showNotification
                // 해당 데이터 제거
                print("Show GetOff Noti")
            }
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
    private func changeComponent(){
        DispatchQueue.main.async {
            if HomeViewController.isRouteSet {
                self.updateRouteSetUI()
            } else {
                self.updateRouteUnsetUI()
            }
        }
    }
    
    
    private func updateRouteSetUI() {
        if !HomeViewController.isMakarTaken {
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

    
    private func updateRouteUnsetUI() {
        self.homeView.changeComponentRouteUnset()
        self.homeView.changeMainDestinationText(destinationText: "MAKAR")
        print("changeComponent: RouteUnset")
    }

    
    private func changeMainTitleText(target: String, minute : Int){
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
    private func showResetRouteAlert(){
        let resetRouteAlert = UIAlertController(title: "경로 초기화", message: "설정된 경로를 초기화하시겠어요?", preferredStyle: .alert)
        resetRouteAlert.addAction( UIAlertAction(title: "확인", style: .destructive, handler: {_ in
            self.changeComponent()
            HomeViewController.isRouteSet = false
        }))
        resetRouteAlert.addAction(UIAlertAction(title: "취소", style: .cancel))
        present(resetRouteAlert, animated: true)
    }
}

extension HomeViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // MARK: CollectionView
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(collectionView == favoriteRouteCollectionView){
            return HomeViewController.favoriteRouteList.count
        } else {
            return recentRouteList.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //즐겨찾는 경로
        if (collectionView == favoriteRouteCollectionView){
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FavoriteRouteCollectionViewCell", for: indexPath) as? FavoriteRouteCollectionViewCell
            else {
                return UICollectionViewCell()
            }
            cell.setData(data: HomeViewController.favoriteRouteList[indexPath.row])
            return cell
        } else {
            //최근 경로
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecentRouteCollectionViewCell", for: indexPath) as? RecentRouteCollectionViewCell
            else {
                return UICollectionViewCell()
            }
            
            cell.setData(data: recentRouteList[indexPath.row])
            //최근경로 삭제
            cell.tapDeleteRecentRouteButton = {[weak self] in
                guard let self else { return }
                // TODO: 최근 경로 편집 API 연결
                self.recentRouteList.remove(at: indexPath.row)
                recentRouteCollectionView.reloadData()
            }
            return cell
        }
    }
    
    //item size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if(collectionView == favoriteRouteCollectionView){
            let data = HomeViewController.favoriteRouteList[indexPath.row]
            let cellWidth = calculateCellWidth(for: data, cell: FavoriteRouteCollectionViewCell())
            return CGSize(width: cellWidth, height: 90)
        } else {
            let data = recentRouteList[indexPath.row]
            let cellWidth = calculateCellWidth(for: data, cell: RecentRouteCollectionViewCell())
            return CGSize(width: cellWidth, height: 90)
        }
    }
    
    // TODO: simplify
    private func calculateCellWidth(for data: Route, cell: UICollectionViewCell) -> CGFloat {
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
        }
        else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let data : Route
        if(collectionView == favoriteRouteCollectionView){
            data = HomeViewController.favoriteRouteList[indexPath.row]
        } else {
            data = recentRouteList[indexPath.row]
        }
        //searchBar Text 수정
        let sourceText = "\(data.sourceStation.stationName) \(data.sourceStation.lineNum)"
        let destinationText = "\(data.destinationStation.stationName) \(data.destinationStation.lineNum)"
        // TODO: 경로 리스트 검색 API 연결
        let searchRouteVC = SearchRouteViewController()
        searchRouteVC.changeSearchBarText(sourceText: sourceText, destinationText: destinationText)
        self.navigationController?.pushViewController(searchRouteVC, animated: true)
    }
    
    func setFavoriteRouteCollectionView(){
        view.addSubview(favoriteRouteCollectionView)
        favoriteRouteCollectionView.backgroundColor = .background
        favoriteRouteCollectionView.showsHorizontalScrollIndicator = false //스크롤바 숨김
        
        favoriteRouteCollectionView.snp.makeConstraints{
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
        view.addSubview(recentRouteCollectionView)
        recentRouteCollectionView.backgroundColor = .background
        recentRouteCollectionView.showsHorizontalScrollIndicator = false //스크롤바 숨김
        
        recentRouteCollectionView.snp.makeConstraints{
            $0.top.equalTo(homeView.recentRouteListText.snp.bottom).inset(-15)
            $0.leading.equalToSuperview().inset(20)
            $0.trailing.equalToSuperview()
            $0.height.equalTo(Metric.collectionViewHeight)
        }
        
        recentRouteCollectionView.register(RecentRouteCollectionViewCell.self, forCellWithReuseIdentifier: "RecentRouteCollectionViewCell")
        recentRouteCollectionView.delegate = self
        recentRouteCollectionView.dataSource = self
    }
}

