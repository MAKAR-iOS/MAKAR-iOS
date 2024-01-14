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
    var makarLeftTime = 0 //막차까지 남은 시간
    var hakarLeftTime = 0 //하차까지 남은 시간
    var makarNotiFlag = false //막차 알림 실행 유무 플래그
    var hakarNotiFlag = false //하차 알림 실행 유무 플래그
    var isMakarTaken = false //막차 측정/하차 측정 구분 플래그
    
    static let makarDateComponents = DateComponents(year: 2024, month: 1, day: 10, hour: 22, minute: 56)
    static let hakarDateComponents = DateComponents(year: 2024, month: 1, day: 10, hour: 22, minute: 58)
    let makarTime = Calendar.current.date(from: makarDateComponents)!//임시 막차 시간
    let hakarTime = Calendar.current.date(from: hakarDateComponents)!//임시 하차 시간
    let makarAlarmTime = 10 //임시 막차 알림 시간
    let hakarAlarmTime = 10 //임시 하차 알림 시간
    
    // TODO: dummylist
    static var favoriteRouteList : [RouteData] = RouteData.favoriteRouteList
    var recentRouteList : [RouteData] = RouteData.recentRouteList
    
    // MARK: UI Components
    private let homeView = HomeView()
    
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
        
        view.addSubview(homeView)
        
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
            
            // TODO: 즐겨찾는 경로 편집 기능
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
        
        homeView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
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
    override func setNavigationBar(){
        super.setNavigationBar()
        //TODO: NavigationBar MAKAR icon custom 필요
        
        navigationItem.title = nil
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: MakarButton.mapButton, style: .plain, target: self, action: #selector(handleMapButtonClickEvent))
        //        navigationItem.leftBarButtonItem = UIBarButtonItem(image: MakarImage.makarLogo, style: .plain, target: nil, action: nil)
    }
    
    @objc private func handleMapButtonClickEvent(){
        postMapButtonClicked()
    }
    
    // MARK: Measure Notification Time
    private func startNotification(){
        DispatchQueue.global(qos: .background).async {
            let runLoop = RunLoop.current
            
            Timer.scheduledTimer(withTimeInterval: 10, repeats: true){ _ in
                if(HomeViewController.isRouteSet){
                    //막차까지 남은 시간 계산
                    if(!self.isMakarTaken){
                        self.makarLeftTime = self.checkNotificationTime(targetDate: self.makarTime)
                        if(self.makarLeftTime < 0){
                            //막차 시간 도달
                            self.isMakarTaken = true
                            self.hakarLeftTime = self.checkNotificationTime(targetDate: self.hakarTime)
                            self.changeComponent()
                        } else {
                            if(self.makarLeftTime == self.makarAlarmTime && !self.makarNotiFlag){
                                //TODO: showNotification
                                self.makarNotiFlag = true
                            }
                            self.changeMainTitleText(target: "막차", minute: self.makarLeftTime)
                        }
                    }else{
                        //하차까지 남은 시간 계산
                        self.hakarLeftTime = self.checkNotificationTime(targetDate: self.hakarTime)
                        if(self.hakarLeftTime == self.hakarAlarmTime && !self.hakarNotiFlag){
                            //TODO: showNotification
                            self.hakarNotiFlag = true
                        }
                        self.changeMainTitleText(target: "하차", minute: self.hakarLeftTime)
                    }
                }
            }
            //하차 시간 까지 비동기 루프 실행
            runLoop.run(until: self.hakarTime)
            
            //하차 시간 도달
            HomeViewController.isRouteSet = false
            //경로 제거
            self.isMakarTaken = false
            self.makarNotiFlag = false
            self.hakarNotiFlag = false
            self.changeComponent()
        }
    }
    
    private func checkNotificationTime(targetDate : Date) -> Int{
        //현재 시간과 설정된 시간 비교
        let date = Date()
        let dateFormatter = DateFormatter().then{
            $0.dateFormat = "YYYY-MM-dd HH:mm:ss"
            $0.locale = Locale(identifier: "ko_kr")
        }
        let currentDate = dateFormatter.date(from: dateFormatter.string(from: date))!
        let targetDate = dateFormatter.date(from: dateFormatter.string(from: targetDate))!
        print("[currentTime] : \(currentDate)")
        return Calendar.current.dateComponents([.minute], from: currentDate, to: targetDate).minute!
    }
    
    
    // MARK: ChangeComponent
    private func changeComponent(){
        DispatchQueue.main.async {
            if(HomeViewController.isRouteSet){
                if(!self.isMakarTaken){
                    self.changeMainTitleText(target: "막차", minute: self.makarLeftTime)
                    self.homeView.changeMainDestinationText(destinationText: "Source")
                }
                else{
                    self.changeMainTitleText(target: "하차", minute: self.hakarLeftTime)
                    self.homeView.changeMainDestinationText(destinationText: "Destination")
                }
                self.homeView.changeComponentRouteSet()
                self.favoriteRouteCollectionView.isHidden = true
                self.recentRouteCollectionView.isHidden = true
                print("changeComponent: RouteSet")
            }
            else{
                self.homeView.changeComponentRouteUnset()
                self.favoriteRouteCollectionView.isHidden = false
                self.recentRouteCollectionView.isHidden = false
                print("changeComponent: RouteUnset")
            }
        }
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
            self.makarNotiFlag = false
            self.hakarNotiFlag = false
        }))
        resetRouteAlert.addAction(UIAlertAction(title: "취소", style: .cancel))
        present(resetRouteAlert, animated: true)
    }
}

extension HomeViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    
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
                
                self.recentRouteList.remove(at: indexPath.row)
                recentRouteCollectionView.reloadData()
            }
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let data : RouteData
        if(collectionView == favoriteRouteCollectionView){
            data = HomeViewController.favoriteRouteList[indexPath.row]
        } else {
            data = recentRouteList[indexPath.row]
        }
        //searchBar Text 수정
        let sourceText = data.sourceText + " " + data.sourceLine
        let destinationText = data.destinationText + " " + data.destinationLine
        
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

