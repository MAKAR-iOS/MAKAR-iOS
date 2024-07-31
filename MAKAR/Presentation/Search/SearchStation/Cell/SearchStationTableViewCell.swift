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
    let stationView = UIView()
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
        contentView.addSubview(stationView)

        stationView.addSubview(lineNumImageView)
        stationView.addSubview(stationNameLabel)
    }

    // MARK: Layout
    func makeConstraints() {
        stationView.snp.makeConstraints {
            $0.edges.equalTo(contentView)
        }

        lineNumImageView.snp.makeConstraints {
            $0.leading.equalTo(stationView).inset(20)
            $0.centerY.equalTo(stationView.snp.centerY)
            $0.height.width.equalTo(18)
        }

        stationNameLabel.snp.makeConstraints {
            $0.leading.equalTo(lineNumImageView.snp.trailing).offset(10)
            $0.centerY.equalTo(stationView)
        }
    }
}
