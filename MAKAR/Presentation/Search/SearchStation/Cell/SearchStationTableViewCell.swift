//
//  SearchStationTableViewCell.swift
//  MAKAR
//
//  Created by 박지윤 on 7/30/24.
//

import UIKit

class SearchStationTableViewCell: UITableViewCell {
    let lineNumImage = LineNumImage()
    let lineNumColor = LineNumColor()

    // MARK: UI Components
    let lineNumImageView = UIImageView()

    let stationNameLabel = UILabel().then {
        $0.textColor = .darkGray
        $0.font = UIFont.systemFont(ofSize: 15, weight: .medium)
    }

    // MARK: Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        configureSubviews()
        makeConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Configuration
    func configureSubviews() {
        addSubview(lineNumImageView)
        addSubview(stationNameLabel)
    }

    // MARK: Layout
    func makeConstraints() {
        contentView.snp.makeConstraints {
            $0.height.equalTo(48)
            $0.width.equalToSuperview()
        }

        lineNumImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(20)
            $0.centerY.equalTo(contentView.snp.centerY)
            $0.height.width.equalTo(18)
        }

        stationNameLabel.snp.makeConstraints {
            $0.leading.equalTo(lineNumImageView.snp.trailing).offset(10)
            $0.centerY.equalTo(contentView.snp.centerY)
        }
    }
}
