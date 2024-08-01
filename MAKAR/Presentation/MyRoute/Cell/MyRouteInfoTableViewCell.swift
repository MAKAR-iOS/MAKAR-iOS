//
//  MyRouteInfoTableViewCell.swift
//  MAKAR
//
//  Created by 박지윤 on 7/29/24.
//

import UIKit

class MyRouteInfoTableViewCell: UITableViewCell {
    // MARK: UI Components
    let lineNumImage = LineNumImage()
    let lineNumColor = LineNumColor()

    private var lineNumImageView = UIImageView()
    private var lineNumVerticalView = UIView()
    private var lineNumColorView = UIView().then {
        $0.layer.cornerRadius = 4
    }

    let walkImageView = UIImageView().then {
        $0.image = MakarImage.walk
    }

    let walkVerticalView1 = UIView().then {
        $0.backgroundColor = .lightGray
    }

    let walkVerticalView2 = UIView().then {
        $0.backgroundColor = .lightGray
    }

    let walkVerticalView3 = UIView().then {
        $0.backgroundColor = .lightGray
    }

    private let sourceStationNameLabel = UILabel().then {
        $0.textColor = .darkGray
        $0.font = UIFont.systemFont(ofSize: 18, weight: .bold)
    }

    private let getOnLabel = UILabel().then {
        $0.text = "승차"
        $0.textColor = .lightGray
        $0.font = UIFont.systemFont(ofSize: 13, weight: .bold)
    }

    private let directLabel = UILabel().then {
        $0.text = "상도 방면"
        $0.textColor = .lightGray
        $0.font = UIFont.systemFont(ofSize: 13, weight: .regular)
    }

    private let leftTimeLabel = UILabel().then {
        $0.text = "10분"
        $0.textColor = .makarRed
        $0.font = UIFont.systemFont(ofSize: 14, weight: .medium)
    }

    private let leftTimeDetailLabel = UILabel().then {
        $0.text = "23:30 (석남행)"
        $0.textColor = .lightGray
        $0.font = UIFont.systemFont(ofSize: 13, weight: .regular)
    }

    private let movingInfoLabel = UILabel().then {
        $0.textColor = .lightGray
        $0.font = UIFont.systemFont(ofSize: 13, weight: .regular)
    }

    private let dividerView = DividerView(dividerType: .thin)

    private let destinationStationNameLabel = UILabel().then {
        $0.textColor = .darkGray
        $0.font = UIFont.systemFont(ofSize: 18, weight: .bold)
    }

    private let getOffLabel = UILabel().then {
        $0.text = "하차"
        $0.textColor = .lightGray
        $0.font = UIFont.systemFont(ofSize: 13, weight: .bold)
    }

    let transferTimeLabel = UILabel().then {
        $0.textColor = .lightGray
        $0.font = UIFont.systemFont(ofSize: 13, weight: .regular)
    }

    let dividerView2 = DividerView(dividerType: .thin)

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
        addSubview(lineNumVerticalView)
        addSubview(lineNumColorView)
        addSubview(walkVerticalView1)
        addSubview(walkVerticalView2)
        addSubview(walkVerticalView3)
        addSubview(walkImageView)
        addSubview(sourceStationNameLabel)
        addSubview(getOnLabel)
        addSubview(directLabel)
        addSubview(leftTimeLabel)
        addSubview(leftTimeDetailLabel)
        addSubview(movingInfoLabel)
        addSubview(dividerView)
        addSubview(destinationStationNameLabel)
        addSubview(getOffLabel)
        addSubview(transferTimeLabel)
        addSubview(dividerView2)
    }

    // MARK: Layout
    func makeConstraints() {
        lineNumImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(25)
            $0.centerY.equalTo(sourceStationNameLabel.snp.centerY)
        }

        lineNumVerticalView.snp.makeConstraints {
            $0.top.equalTo(lineNumImageView.snp.bottom)
            $0.centerX.equalTo(lineNumImageView.snp.centerX)
            $0.width.equalTo(1)
            $0.bottom.equalTo(destinationStationNameLabel.snp.centerY)
        }

        lineNumColorView.snp.makeConstraints {
            $0.centerX.equalTo(lineNumImageView.snp.centerX)
            $0.centerY.equalTo(destinationStationNameLabel.snp.centerY)
            $0.width.height.equalTo(8)
        }

        walkVerticalView1.snp.makeConstraints {
            $0.centerX.equalTo(lineNumImageView.snp.centerX)
            $0.top.equalTo(lineNumColorView.snp.bottom)
            $0.bottom.equalTo(walkImageView.snp.top).offset(-4)
            $0.width.equalTo(1)
        }

        walkVerticalView2.snp.makeConstraints {
            $0.centerX.equalTo(lineNumImageView.snp.centerX)
            $0.top.equalTo(walkImageView.snp.bottom).offset(4)
            $0.width.equalTo(1)
            $0.bottom.equalToSuperview()
        }

        walkVerticalView3.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.centerX.equalTo(lineNumImageView.snp.centerX)
            $0.width.equalTo(1)
            $0.bottom.equalTo(lineNumImageView.snp.top)
        }

        walkImageView.snp.makeConstraints {
            $0.centerX.equalTo(lineNumImageView.snp.centerX)
            $0.centerY.equalTo(transferTimeLabel.snp.centerY)
            $0.width.height.equalTo(10)
        }

        sourceStationNameLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(20)
            $0.leading.equalToSuperview().inset(50)
        }

        getOnLabel.snp.makeConstraints {
            $0.bottom.equalTo(sourceStationNameLabel.snp.bottom).offset(-1)
            $0.leading.equalTo(sourceStationNameLabel.snp.trailing).offset(8)
        }

        directLabel.snp.makeConstraints {
            $0.top.equalTo(sourceStationNameLabel.snp.bottom).offset(10)
            $0.leading.equalToSuperview().inset(50)
        }

        leftTimeLabel.snp.makeConstraints {
            $0.top.equalTo(directLabel.snp.bottom).offset(5)
            $0.leading.equalToSuperview().inset(50)
        }

        leftTimeDetailLabel.snp.makeConstraints {
            $0.centerY.equalTo(leftTimeLabel.snp.centerY)
            $0.leading.equalTo(leftTimeLabel.snp.trailing).offset(8)
        }

        movingInfoLabel.snp.makeConstraints {
            $0.top.equalTo(leftTimeLabel.snp.bottom).offset(5)
            $0.leading.equalToSuperview().inset(50)
        }

        dividerView.snp.makeConstraints {
            $0.top.equalTo(movingInfoLabel.snp.bottom).offset(14)
            $0.leading.equalToSuperview().inset(50)
            $0.trailing.equalToSuperview().inset(20)
        }

        destinationStationNameLabel.snp.makeConstraints {
            $0.top.equalTo(dividerView.snp.bottom).offset(14)
            $0.leading.equalToSuperview().inset(50)
        }

        getOffLabel.snp.makeConstraints {
            $0.bottom.equalTo(destinationStationNameLabel.snp.bottom).offset(-1)
            $0.leading.equalTo(destinationStationNameLabel.snp.trailing).offset(8)
        }

        transferTimeLabel.snp.makeConstraints {
            $0.top.equalTo(getOffLabel.snp.bottom).offset(10)
            $0.leading.equalToSuperview().inset(50)
        }

        dividerView2.snp.makeConstraints {
            $0.top.equalTo(transferTimeLabel.snp.bottom).offset(14)
            $0.leading.equalToSuperview().inset(50)
            $0.trailing.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview()
        }
    }
}

extension MyRouteInfoTableViewCell {
    func setData(data: SubRouteDTO?) {
        lineNumImage.addLineNum()
        lineNumColor.addLineNum()

        guard let data = data else { return }

        if let lineImg = lineNumImage.lineNumMap[data.lineNum] {
            lineNumImageView.image = lineImg
        } else {
            lineNumImageView.image = MakarImage.line0
        }

        lineNumVerticalView.backgroundColor = lineNumColor.lineNumColorMap[data.lineNum]
        lineNumColorView.backgroundColor = lineNumColor.lineNumColorMap[data.lineNum]

        sourceStationNameLabel.text = data.fromStationName
        movingInfoLabel.text = "6개 역 이동 (" + String(data.sectionTime) + "분)"

        destinationStationNameLabel.text = data.toStationName
        transferTimeLabel.text = "환승 도보 (" + String(data.transferTime) + "분)"
    }
}
