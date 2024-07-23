//
//  TimetableViewController.swift
//  MAKAR
//
//  Created by 박지윤 on 2023/12/25.
//

import UIKit

class TimetableViewController: BaseViewController {
    // tab
    private let tabView = TabView()
    
    // page
    private lazy var pagerView: PagerView = {
        return PagerView(items: self.items)
    }()
    
//    private let items = [
//        "jake",
//        "iOS 앱",
//        "PagerView",
//        "iOS",
//        "아이폰",
//        "Scroll 처리"
//    ]
    private let items = [
        "숭실대입구역 7호선",
        "대림역 2호선"
    ]
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabView.dataSource = items
        setupLayout()
        handleScroll()
    }
    
    private func setupLayout() {
        view.addSubview(tabView)
        view.addSubview(pagerView)
        
        tabView.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(50)
        }
        pagerView.snp.makeConstraints {
            $0.top.equalTo(tabView.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    private func handleScroll() {
        tabView.syncUnderlineView(index: 0, underlineView: tabView.highlightView)
        
        tabView.didTap = { [weak self] index in
            guard let self else { return }
            pagerView.scroll(to: index)
            tabView.scroll(to: index)
            tabView.syncUnderlineView(index: index, underlineView: tabView.highlightView)
        }
        
        pagerView.didScroll = { [weak self] ratioX in
            guard let self else { return }
            tabView.scroll(to: ratioX)
            tabView.syncUnderlineView(ratio: ratioX, underlineView: tabView.highlightView)
        }
        
        pagerView.didEndScroll = { [weak self] index in
            guard let self else { return }
            tabView.syncUnderlineView(index: index, underlineView: tabView.highlightView)
        }
    }
}
