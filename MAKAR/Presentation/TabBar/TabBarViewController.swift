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
        static let tabBarHeight = 90.0
    }

    // MARK: UI Components
    let homeViewController = HomeViewController()
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
        tabFrame.size.height = Metric.tabBarHeight
        tabFrame.origin.y = view.frame.size.height - Metric.tabBarHeight
        tabBar.frame = tabFrame
    }

    // MARK: TabBar
    private func setupTabBar() {
        homeViewController.title = "홈"
        myRouteViewController.title = "나의 경로"
        notificationViewController.title = "알림"
        myPageViewController.title = "MY"

        homeViewController.tabBarItem.image = MakarButton.homeButton
        myRouteViewController.tabBarItem.image = MakarButton.myRouteButton
        notificationViewController.tabBarItem.image = MakarButton.notificationButton
        myPageViewController.tabBarItem.image = MakarButton.myPageButton

        homeViewController.tabBarItem.selectedImage = MakarButton.homeFilledButton
        myRouteViewController.tabBarItem.selectedImage = MakarButton.myRouteButton
        notificationViewController.tabBarItem.selectedImage = MakarButton.notificationFilledButton
        myPageViewController.tabBarItem.selectedImage = MakarButton.myPageFilledButton

        let tabBarItems = [homeViewController.tabBarItem, myRouteViewController.tabBarItem, notificationViewController.tabBarItem, myPageViewController.tabBarItem]
        for item in tabBarItems {
            item?.setTitleTextAttributes([.font: UIFont.systemFont(ofSize: 11)], for: .normal)
            item?.imageInsets = UIEdgeInsets(top: 2, left: 0, bottom: -6, right: 0)
            item?.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: 3)
        }

        homeViewController.navigationItem.largeTitleDisplayMode = .never
        myRouteViewController.navigationItem.largeTitleDisplayMode = .automatic
        notificationViewController.navigationItem.largeTitleDisplayMode = .automatic
        myPageViewController.navigationItem.largeTitleDisplayMode = .automatic

        let navigationHome = UINavigationController(rootViewController: homeViewController)
        let navigationMyRoute = UINavigationController(rootViewController: myRouteViewController)
        let navigationNotification = UINavigationController(rootViewController: notificationViewController)
        let navigationMyPage = UINavigationController(rootViewController: myPageViewController)

        navigationHome.navigationBar.prefersLargeTitles = false
        navigationMyRoute.navigationBar.prefersLargeTitles = true
        navigationNotification.navigationBar.prefersLargeTitles = true
        navigationMyPage.navigationBar.prefersLargeTitles = true

        setViewControllers([navigationHome,
                            navigationMyRoute,
                            navigationNotification,
                            navigationMyPage], animated: false)
    }
    
    private func setupTabBarUI() {
        tabBar.backgroundColor = .white
        tabBar.tintColor = .makarBlue
        tabBar.unselectedItemTintColor = .lightGray4

        tabBar.layer.borderColor = UIColor.lightGray6.cgColor
        tabBar.layer.borderWidth = 1

        tabBar.backgroundImage = UIImage()
        tabBar.shadowImage = UIImage()
        tabBar.clipsToBounds = true
    }
}
