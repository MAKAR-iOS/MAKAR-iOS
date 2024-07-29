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
        static let tabBarHeight: CGFloat = 90.0
        static let titleFontSize: CGFloat = 11.0
        static let imageTopInset: CGFloat = 0.0
        static let imageBottomInset: CGFloat = -4.0
        static let titleVerticalOffset: CGFloat = 3.0
    }

    // MARK: UI Components
    let homeViewController = HomeViewController()
    let myRouteViewController = MyRouteViewController()
    let notificationViewController = NotificationViewController()
    let myPageViewController = MyPageViewController()

    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTabBarViewController()
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
    private func setupTabBarViewController() {
        homeViewController.title = "홈"
        myRouteViewController.title = "나의 경로"
        notificationViewController.title = "알림"
        myPageViewController.title = "MY"
        
        setupTabBarItem(for: homeViewController, image: MakarButton.homeButton, selectedImage: MakarButton.homeFilledButton)
        setupTabBarItem(for: myRouteViewController, image: MakarButton.myRouteButton, selectedImage: MakarButton.myRouteButton)
        setupTabBarItem(for: notificationViewController, image: MakarButton.notificationButton, selectedImage: MakarButton.notificationFilledButton)
        setupTabBarItem(for: myPageViewController, image: MakarButton.myPageButton, selectedImage: MakarButton.myPageFilledButton)

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

    private func setupTabBarItem(for viewController: UIViewController, image: UIImage, selectedImage: UIImage) {
        let tabBarItem = UITabBarItem(title: viewController.title, image: image, selectedImage: selectedImage)
        tabBarItem.setTitleTextAttributes([.font: UIFont.systemFont(ofSize: Metric.titleFontSize)], for: .normal)
        tabBarItem.imageInsets = UIEdgeInsets(top: Metric.imageTopInset, left: 0, bottom: Metric.imageBottomInset, right: 0)
        tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: Metric.titleVerticalOffset)
        viewController.tabBarItem = tabBarItem
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
