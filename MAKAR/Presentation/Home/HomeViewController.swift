//
//  HomeViewController.swift
//  MAKAR
//
//  Created by 박지윤 on 2023/12/25.
//

import UIKit

class HomeViewController: BaseViewController {
    
    // MARK: Flag
    static var isRouteSet = false //경로 설정 유무 플래그
    var leftTime = 0 //막차/하차까지 남은 시간
    var makarNotiFlag = false //막차 알림 실행 유무 플래그
    var hakarNotiFlag = false //하차 알림 실행 유무 플래그
    
    static let makarDateComponents = DateComponents(year: 2024, month: 1, day: 1, hour: 21, minute: 00)
    static let hakarDateComponents = DateComponents(year: 2024, month: 1, day: 1, hour: 22, minute: 00)
    let makarTime = Calendar.current.date(from: makarDateComponents)!//임시 막차 시간
    let hakarTime = Calendar.current.date(from: hakarDateComponents)!//임시 하차 시간
    
    // MARK: UI Components
    private let homeView = HomeView()

    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .background
        changeComponent()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        startNotification()
        changeComponent()
    }

    // MARK: Configuration
    override func configureSubviews() {
        super.configureSubviews()

        view.addSubview(homeView)
        
        homeView.tapResetRouteButton = {[weak self] in
            guard let self else { return }
            
            //TODO: Alert로 수정 필요
            changeComponent()
            HomeViewController.isRouteSet = false
            makarNotiFlag = false
            hakarNotiFlag = false
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
        if(HomeViewController.isRouteSet){
            if(!makarNotiFlag){
                //막차까지 남은 시간 계산
                leftTime = checkNotificationTime(targetDate: makarTime)
                
            } else if(!hakarNotiFlag){
                //하차까지 남은 시간 계산
                leftTime = checkNotificationTime(targetDate: hakarTime)
                
            }else{
                
            }
            
            
        }else{
            
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
}

extension HomeViewController {
    
    // MARK: ChangeComponent
    private func changeComponent(){
        if(HomeViewController.isRouteSet){
            homeView.changeComponentRouteSet(leftTime: leftTime)
            print("changeComponent: RouteSet")
        }
        else{
            homeView.changeComponentRouteUnset()
            print("changeComponent: RouteUnset")
        }
        //임시 method
        homeView.layoutIfNeeded()
    }
}
