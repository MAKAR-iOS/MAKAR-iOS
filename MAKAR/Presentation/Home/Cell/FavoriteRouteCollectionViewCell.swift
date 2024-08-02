//
//  FavoriteRouteCollectionViewCell.swift
//  MAKAR
//
//  Created by 김다은 on 1/9/24.
//

import UIKit
class FavoriteRouteCollectionViewCell: UICollectionViewCell {
    // MARK: Constants
    private enum Metric {
        static let lineNumSize = 15
    }

    // MARK: UI Components
    let lineNumImage = LineNumImage()

    private var sourceLineNumImageView = UIImageView()

    var sourceTextLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 13, weight: .light)
        $0.sizeToFit()
    }

    private var moreRightLabel = UILabel().then {
        $0.text = ">"
        $0.font = .systemFont(ofSize: 13, weight: .light)
        $0.sizeToFit()
    }

    private var destinationLineNumImageView = UIImageView()

    var destinationTextLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 13, weight: .light)
        $0.sizeToFit()
    }

    // MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)

        configure()
        configureSubviews()
        makeConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Configuration
    func configure() {
        self.layer.cornerRadius = 10
        self.backgroundColor = .white
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.lightGray5.cgColor
    }

    func configureSubviews() {
        addSubview(sourceLineNumImageView)
        addSubview(sourceTextLabel)
        addSubview(moreRightLabel)
        addSubview(destinationLineNumImageView)
        addSubview(destinationTextLabel)
    }

    // MARK: Layout
    func makeConstraints() {
        sourceLineNumImageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(25)
            $0.leading.equalToSuperview().inset(10)
            $0.width.height.equalTo(Metric.lineNumSize)
        }

        sourceTextLabel.snp.makeConstraints {
            $0.centerY.equalTo(sourceLineNumImageView.snp.centerY)
            $0.leading.equalTo(sourceLineNumImageView.snp.trailing).offset(3)
        }

        moreRightLabel.snp.makeConstraints {
            $0.top.equalTo(sourceTextLabel.snp.bottom).offset(12)
            $0.leading.equalToSuperview().inset(10)
        }

        destinationLineNumImageView.snp.makeConstraints {
            $0.centerY.equalTo(moreRightLabel.snp.centerY)
            $0.leading.equalTo(moreRightLabel.snp.trailing).offset(3)
            $0.width.height.equalTo(Metric.lineNumSize)
        }

        destinationTextLabel.snp.makeConstraints {
            $0.centerY.equalTo(destinationLineNumImageView.snp.centerY)
            $0.leading.equalTo(destinationLineNumImageView.snp.trailing).offset(3)
        }
    }

    func setData(data: BriefRouteDTO?) {
        lineNumImage.addLineNum()

        guard let data = data else { return }

        sourceTextLabel.text = data.sourceStationName
        destinationTextLabel.text = data.destinationStationName

        setLineImage(for: sourceLineNumImageView, with: data.sourceLineNum)
        setLineImage(for: destinationLineNumImageView, with: data.destinationLineNum)
     }

    private func setLineImage(for imageView: UIImageView, with lineNum: String) {
        if let lineImg = lineNumImage.lineNumMap[lineNum] {
            imageView.image = lineImg
        } else {
            imageView.image = MakarImage.line0
        }
    }
}
