//
//  GetOffNotiSetView.swift
//  MAKAR
//
//  Created by 박지윤 on 1/17/24.
//

import UIKit

class GetOffNotiSetView: BaseView {

    let getOffStationArr = ["없음", "1전 역", "2전 역", "3전 역"]
//    var tempMakarTime = 5
//    var selectedMakarTime: [Int] = [5]

    // MARK: UI Components
    let makarNotiView = MakarNotiView()
    let getOffNotiView = GetOffNotiView()

    private let setView = UIView().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 8
    }

    private let getOffNotiSetLabel = UILabel().then {
        $0.text = "하차 알림 설정"
        $0.textColor = .black
        $0.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
    }

    let getOffSetTableView = UITableView().then {
        $0.separatorStyle = .none
        $0.register(
            GetOffNotiSetTableViewCell.self,
            forCellReuseIdentifier: GetOffNotiSetTableViewCell.identifier
        )
    }

    private let buttonStackView = UIStackView().then {
//        $0.spacing = 20
        $0.distribution = .fillEqually
    }

    private let confirmButton = BaseButton().then {
        $0.setTitle("확인", for: .normal)
        $0.setTitleColor(.darkGray2, for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .regular)
    }

    private let cancelButton = BaseButton().then {
        $0.setTitle("취소", for: .normal)
        $0.setTitleColor(.darkGray2, for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .regular)
    }

    // MARK: Properties
    var tapConfirmButton: (() -> Void)?
    var tapCancelButton: (() -> Void)?

    // MARK: Configuration
    override func configureSubviews() {
        super.configureSubviews()

        addSubview(setView)

        setView.addSubview(getOffNotiSetLabel)
        setView.addSubview(getOffSetTableView)
        setView.addSubview(buttonStackView)

        buttonStackView.addArrangedSubview(cancelButton)
        buttonStackView.addArrangedSubview(confirmButton)

        getOffSetTableView.dataSource = self
        getOffSetTableView.delegate = self
        backgroundColor = .black.withAlphaComponent(0.3)

        confirmButton.addTarget(self, action: #selector(handleConfirmEvent), for: .touchUpInside)
        cancelButton.addTarget(self, action: #selector(handleCancelEvent), for: .touchUpInside)
    }

    // MARK: Layout
    override func makeConstraints() {
        super.makeConstraints()

        setView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(75)
            $0.height.equalToSuperview().multipliedBy(0.31)
            $0.centerY.equalTo(safeAreaLayoutGuide.snp.centerY)
        }

        getOffNotiSetLabel.snp.makeConstraints {
            $0.top.equalTo(setView).inset(20)
            $0.leading.trailing.equalToSuperview().inset(20)
        }

        getOffSetTableView.snp.makeConstraints {
            $0.top.equalTo(getOffNotiSetLabel.snp.bottom).offset(15)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(150)
        }

        buttonStackView.snp.makeConstraints {
            $0.top.equalTo(getOffSetTableView.snp.bottom).offset(12)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
    }

    // MARK: Event
    @objc private func handleConfirmEvent() {
        tapConfirmButton?()
    }

    @objc private func handleCancelEvent() {
        tapCancelButton?()
    }
}

extension GetOffNotiSetView: UITableViewDataSource {
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return getOffStationArr.count
    }

    func tableView(_ tableView: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }

    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = getOffSetTableView.dequeueReusableCell(
            withIdentifier: GetOffNotiSetTableViewCell.identifier,
            for: indexPath
        ) as? GetOffNotiSetTableViewCell else { return UITableViewCell() }

        cell.getOffStationLabel.text = getOffStationArr[indexPath.row]
        cell.selectionStyle = .none

        if (indexPath.row == 0) {
            cell.getOffStationLabel.textColor = .makarBlue
        } else {
            cell.checkButton.isHidden = true
        }

        return cell
    }
}

extension GetOffNotiSetView: UITableViewDelegate {
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        
    }
}
