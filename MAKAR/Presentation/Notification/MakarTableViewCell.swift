//
//  MakarTableViewCell.swift
//  MAKAR
//
//  Created by 박지윤 on 2024/01/08.
//

import UIKit

final class MakarTableViewCell: UITableViewCell {

    static let identifier = "MakarTableViewCell"

    // MARK: UI Components
    private(set) var makarNameLabel = UILabel().then {
        $0.textColor = .darkGray
        $0.font = .systemFont(ofSize: 16, weight: .medium)
    }

    private(set) var makarTimeLabel = UILabel().then {
        $0.textColor = .makarBlue
        $0.font = .systemFont(ofSize: 16, weight: .bold)
    }

    private(set) var deleteButton = BaseButton().then {
        $0.setImage(MakarButton.deleteButton, for: .normal)
    }

    // MARK: init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
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
        contentView.addSubview(makarNameLabel)
        contentView.addSubview(makarTimeLabel)
        contentView.addSubview(deleteButton)
    }

    // MARK: Layout
    private func makeConstraints() {
        makarNameLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(20)
            $0.centerY.equalToSuperview()
        }

        makarTimeLabel.snp.makeConstraints {
            $0.leading.equalTo(makarNameLabel.snp.trailing).offset(14)
            $0.centerY.equalToSuperview()
        }

        deleteButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(16)
            $0.centerY.equalToSuperview()
            $0.height.width.equalTo(23)
        }
    }
}
