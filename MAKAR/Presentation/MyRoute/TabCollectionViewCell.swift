//
//  TabCollectionViewCell.swift
//  MAKAR
//
//  Created by 박지윤 on 1/24/24.
//

import UIKit

final class TabCollectionViewCell: UICollectionViewCell {

    static let identifier = "TabCollectionViewCell"

    // MARK: UI Components
    private(set) var stationLabel = UILabel().then {
        $0.text = "eeooe"
        $0.textColor = .darkGray
        $0.font = .systemFont(ofSize: 16, weight: .medium)
    }

    // MARK: init
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureSubviews()
        makeConstraints()
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Configuration
    private func configureSubviews() {
        contentView.addSubview(stationLabel)

//        deleteButton.addTarget(self, action: #selector(handleDeleteNotiRouteButton), for: .touchUpInside)
    }

    // MARK: Properties
    var tapDeleteNotiButton: (() -> Void)?

    // MARK: Layout
    private func makeConstraints() {
        stationLabel.snp.makeConstraints {
            $0.leading.top.equalToSuperview().inset(20)
        }
    }

    // MARK: Event
    @objc func handleDeleteNotiRouteButton(){
        tapDeleteNotiButton?()
    }
}
