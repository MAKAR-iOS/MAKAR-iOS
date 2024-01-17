//
//  GetOffNotiSetTableViewCell.swift
//  MAKAR
//
//  Created by 박지윤 on 1/17/24.
//

import UIKit

final class GetOffNotiSetTableViewCell: UITableViewCell {

    static let identifier = "GetOffNotiSetTableViewCell"

    // MARK: UI Components
    private(set) var getOffStationLabel = UILabel().then {
        $0.textColor = .darkGray2
        $0.font = .systemFont(ofSize: 14, weight: .medium)
    }

    private(set) var checkButton = BaseButton().then {
        $0.setImage(MakarButton.checkButton, for: .normal)
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
        contentView.addSubview(getOffStationLabel)
        contentView.addSubview(checkButton)
    }

    // MARK: Layout
    private func makeConstraints() {
        getOffStationLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(11)
            $0.centerY.equalToSuperview()
        }

        checkButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(12)
            $0.centerY.equalToSuperview()
            $0.height.equalTo(10)
            $0.width.equalTo(12)
        }
    }
}
