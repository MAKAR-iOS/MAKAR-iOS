//
//  RecentRouteCollectionViewCell.swift
//  MAKAR
//
//  Created by 김다은 on 1/9/24.
//

import UIKit
class RecentRouteCollectionViewCell: UICollectionViewCell {
    // MARK: Constants
    private enum Metric {
        static let lineNumSize = 15
        static let deleteButtonSize = 15
    }

    // MARK: UI Components
    let lineNumImage = LineNumImage()

    private var deleteRecentRouteButton = BaseButton().then {
        $0.setImage(MakarButton.deleteButton, for: .normal)
    }

    private var sourceLineNumImageView = UIImageView()

    var sourceText = UILabel().then {
        $0.font = .systemFont(ofSize: 13, weight: .light)
        $0.sizeToFit()
    }

    private var moreRightLabel = UILabel().then {
        $0.text = ">"
        $0.font = .systemFont(ofSize: 13, weight: .light)
        $0.sizeToFit()
    }

    private var destinationLineNumImageView = UIImageView()

    var destinationText = UILabel().then {
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
        addSubview(deleteRecentRouteButton)
        addSubview(sourceLineNumImageView)
        addSubview(sourceText)
        addSubview(moreRightLabel)
        addSubview(destinationLineNumImageView)
        addSubview(destinationText)

        deleteRecentRouteButton.addTarget(self, action: #selector(handleDeleteRecentRouteButton), for: .touchUpInside)
    }

    // MARK: Properties
    var tapDeleteRecentRouteButton: (() -> Void)?

    // MARK: Layout
    func makeConstraints() {

        deleteRecentRouteButton.snp.makeConstraints {
            $0.top.trailing.equalToSuperview().inset(10)
            $0.width.height.equalTo(Metric.deleteButtonSize)
        }

        sourceLineNumImageView.snp.makeConstraints {
            $0.top.equalTo(deleteRecentRouteButton.snp.bottom).inset(-10)
            $0.leading.equalToSuperview().inset(10)
            $0.width.height.equalTo(Metric.lineNumSize)
        }

        sourceText.snp.makeConstraints {
            $0.top.equalTo(sourceLineNumImageView.snp.top)
            $0.leading.equalTo(sourceLineNumImageView.snp.trailing).inset(-3)
        }

        moreRightLabel.snp.makeConstraints {
            $0.top.equalTo(sourceText.snp.bottom).inset(-12)
            $0.leading.equalToSuperview().inset(10)
        }

        destinationLineNumImageView.snp.makeConstraints {
            $0.centerY.equalTo(moreRightLabel.snp.centerY)
            $0.leading.equalTo(moreRightLabel.snp.trailing).inset(-3)
            $0.width.height.equalTo(Metric.lineNumSize)
        }

        destinationText.snp.makeConstraints {
            $0.top.equalTo(destinationLineNumImageView.snp.top)
            $0.leading.equalTo(destinationLineNumImageView.snp.trailing).inset(-3)
        }
    }

    func setData(data: BriefRouteDTO?) {
        lineNumImage.addLineNum()

        guard let data = data else { return }

        sourceText.text = data.sourceStationName
        destinationText.text = data.destinationStationName

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

    // MARK: Event
    @objc func handleDeleteRecentRouteButton() {
        tapDeleteRecentRouteButton?()
    }
}
