//
//  TabBarViewController.swift
//  MAKAR
//
//  Created by 박지윤 on 2023/12/25.
//

import UIKit

class TabBarViewController: UITabBarController {

    // MARK: Constants
    private enum Metric {
        static let tabBarHeight = 90
        static let buttonHeight = 50
        static let tabBarRadius = 15
    }

    // MARK: UI Components
    let homeViewController = HomeViewController()
    let timetableViewController = TimetableViewController()
    let myRouteViewController = MyRouteViewController()
    let notificationViewController = NotificationViewController()
    let myPageViewController = MyPageViewController()

    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTabBar()
        setupTabBarUI()
    }

    // MARK: viewDidLayoutSubviews
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        var tabFrame = tabBar.frame
        tabFrame.size.height = CGFloat(Metric.tabBarHeight)
        tabFrame.origin.y = view.frame.size.height - CGFloat(Metric.tabBarHeight)
        tabBar.frame = tabFrame
    }

    // MARK: TabBar
    private func setupTabBar() {
        homeViewController.title = "홈"
        timetableViewController.title = "시간표"
        myRouteViewController.title = nil
        notificationViewController.title = "알림"
        myPageViewController.title = "MY"

        homeViewController.tabBarItem.image = MakarButton.homeButton
        timetableViewController.tabBarItem.image = MakarButton.timetableButton
        myRouteViewController.tabBarItem.image = MakarButton.myRouteButton
        notificationViewController.tabBarItem.image = MakarButton.notificationButton
        myPageViewController.tabBarItem.image = MakarButton.myPageButton

        homeViewController.tabBarItem.selectedImage = MakarButton.homeFilledButton
        timetableViewController.tabBarItem.selectedImage = MakarButton.timetableFilledButton
        myRouteViewController.tabBarItem.selectedImage = MakarButton.myRouteButton
        notificationViewController.tabBarItem.selectedImage = MakarButton.notificationFilledButton
        myPageViewController.tabBarItem.selectedImage = MakarButton.myPageFilledButton

        homeViewController.navigationItem.largeTitleDisplayMode = .automatic
        timetableViewController.navigationItem.largeTitleDisplayMode = .automatic
        myRouteViewController.navigationItem.largeTitleDisplayMode = .automatic
        notificationViewController.navigationItem.largeTitleDisplayMode = .automatic
        myPageViewController.navigationItem.largeTitleDisplayMode = .automatic

        let navigationHome = UINavigationController(rootViewController: homeViewController)
        let navigationTimetable = UINavigationController(rootViewController: timetableViewController)
        let navigationMyRoute = UINavigationController(rootViewController: myRouteViewController)
        let navigationNotification = UINavigationController(rootViewController: notificationViewController)
        let navigationMyPage = UINavigationController(rootViewController: myPageViewController)

        navigationHome.navigationBar.prefersLargeTitles = true
        navigationTimetable.navigationBar.prefersLargeTitles = true
        navigationMyRoute.navigationBar.prefersLargeTitles = true
        navigationNotification.navigationBar.prefersLargeTitles = true
        navigationMyPage.navigationBar.prefersLargeTitles = true

        setViewControllers([navigationHome,
                            navigationTimetable,
                            navigationMyRoute,
                            navigationNotification,
                            navigationMyPage], animated: false)

        UITabBarItem.appearance().titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -4)
    }
    
    private func setupTabBarUI() {
        tabBar.backgroundColor = .white
        tabBar.tintColor = .makarBlue

        tabBar.layer.cornerRadius = CGFloat(Metric.tabBarRadius)
        tabBar.layer.borderColor = UIColor.lightgray5.cgColor
        tabBar.layer.borderWidth = 1

        tabBar.layer.masksToBounds = false
        tabBar.layer.shadowColor = UIColor.darkgray.withAlphaComponent(0.2).cgColor
        tabBar.layer.shadowOffset = .zero
        tabBar.layer.shadowOpacity = 0.5
        tabBar.layer.shadowRadius = CGFloat(Metric.tabBarRadius)
    }
}
