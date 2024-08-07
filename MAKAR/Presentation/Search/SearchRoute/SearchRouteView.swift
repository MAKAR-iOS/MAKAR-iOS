//
//  SearchRouteView.swift
//  MAKAR
//
//  Created by 박지윤 on 2023/12/25.
//

import UIKit

class SearchRouteView: BaseView {

    // MARK: UI Components
    private let sourceTextLabel = UILabel().then {
        $0.text = "출발역"
        $0.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        $0.textColor = .darkGray
    }

    private let destinationTextLabel = UILabel().then {
        $0.text = "도착역"
        $0.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        $0.textColor = .darkGray
    }

    let sourceSearchBar = StationSearchBarButton(setTitle: "출발역을 입력하세요")
    let destinationSearchBar = StationSearchBarButton(setTitle: "도착역을 입력하세요")

    private let swapButton = BaseButton().then {
        var config = UIButton.Configuration.plain()
        config.baseForegroundColor = .white
        config.cornerStyle = .capsule
        config.image = MakarButton.swapButton
        $0.configuration = config
    }

    private let searchRouteButton = RouteButton().then {
        $0.setTitle("경로 찾기", for: .normal)
    }

    private let dividerView = DividerView(dividerType: .thick)

    // MARK: Properties
    var tapSwapStationButton: (() -> Void)?
    var tapSourceSearchBar: (() -> Void)?
    var tapDestinationSearchBar: (() -> Void)?
    var tapSearchRouteButton: (() -> Void)?

    // MARK: Configuration
    override func configureSubviews() {
        super.configureSubviews()

        addSubview(sourceTextLabel)
        addSubview(destinationTextLabel)
        addSubview(sourceSearchBar)
        addSubview(destinationSearchBar)
        addSubview(swapButton)
        addSubview(searchRouteButton)
        addSubview(dividerView)

        swapButton.addTarget(self, action: #selector(handleSwapButtonClickEvent), for: .touchUpInside)
        sourceSearchBar.addTarget(self, action: #selector(handleSourceSearchBarClickEvent), for: .touchUpInside)
        destinationSearchBar.addTarget(self, action: #selector(handleDestinationSearchBarClickEvent), for: .touchUpInside)
        searchRouteButton.addTarget(self, action: #selector(handleSearchRouteButtonClickEvent), for: .touchUpInside)
    }

    // MARK: Layout
    override func makeConstraints() {
        super.makeConstraints()

        sourceTextLabel.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).inset(20)
            $0.leading.equalToSuperview().inset(20)
            $0.width.equalTo(Metric.textWidth)
        }

        destinationTextLabel.snp.makeConstraints {
            $0.top.equalTo(sourceTextLabel.snp.bottom).offset(40)
            $0.leading.equalTo(sourceTextLabel.snp.leading)
            $0.width.equalTo(Metric.textWidth)
        }

        swapButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(20)
            $0.centerY.equalTo(sourceTextLabel.snp.bottom).offset(25)
            $0.height.equalTo(Metric.swapButtonHeight)
            $0.width.equalTo(Metric.swapButtonWidth)
        }

        sourceSearchBar.snp.makeConstraints {
            $0.centerY.equalTo(sourceTextLabel)
            $0.leading.equalTo(sourceTextLabel.snp.trailing).offset(8)
            $0.trailing.equalTo(swapButton.snp.leading).offset(5)
            $0.height.equalTo(Metric.searchBarButtonHeight)
        }

        destinationSearchBar.snp.makeConstraints {
            $0.centerY.equalTo(destinationTextLabel)
            $0.leading.equalTo(destinationTextLabel.snp.trailing).offset(8)
            $0.trailing.equalTo(swapButton.snp.leading).offset(5)
            $0.height.equalTo(Metric.searchBarButtonHeight)
        }

        searchRouteButton.snp.makeConstraints {
            $0.top.equalTo(destinationSearchBar.snp.bottom).offset(20)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(Metric.makarButtonHeight)
        }

        dividerView.snp.makeConstraints {
            $0.top.equalTo(searchRouteButton.snp.bottom).offset(16)
            $0.horizontalEdges.equalToSuperview()
        }
    }

    // MARK: Event
    @objc private func handleSwapButtonClickEvent() {
        tapSwapStationButton?()
    }

    @objc private func handleSourceSearchBarClickEvent() {
        tapSourceSearchBar?()
    }

    @objc private func handleDestinationSearchBarClickEvent() {
        tapDestinationSearchBar?()
    }

    @objc private func handleSearchRouteButtonClickEvent() {
        tapSearchRouteButton?()
    }

    func changeSearchBarText(sourceText: String, destinationText: String) {
        self.sourceSearchBar.setTitle(sourceText, for: .normal)
        self.destinationSearchBar.setTitle(destinationText, for: .normal)
    }
}
