//
//  MakarNotiView.swift
//  MAKAR
//
//  Created by 박지윤 on 2024/01/08.
//

import UIKit

class MakarNotiView: BaseView {

    let makarTimeArr = [5, 10, 15, 20, 25, 30]
    var tempMakarTime = 5
    var selectedMakarTime = 0

    // MARK: UI Components
    private let makarNotiLabel = UILabel().then {
        $0.text = "막차 알림"
        $0.textColor = .black
        $0.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
    }

    private let makarNotiAddButton = BaseButton().then {
        $0.setImage(MakarButton.addButton, for: .normal)
    }

    var makarAlertController = UIAlertController(
        title: "막차 알림",
        message: nil,
        preferredStyle: .alert
    )

    private let makarPickerView = UIPickerView()
    private let pickerContainerView = UIViewController()

    private let makarTableView = UITableView().then {
        $0.separatorStyle = .none
        $0.register(
            MakarTableViewCell.self,
            forCellReuseIdentifier: MakarTableViewCell.identifier
        )
        
    }

    // MARK: Properties
    var tapMakarAdd: (() -> Void)?

    // MARK: Configuration
    override func configureSubviews() {
        super.configureSubviews()

        setMakarNotiView()
        setMakarAlertController()

        makarTableView.dataSource = self
        makarTableView.delegate = self
        makarTableView.backgroundColor = .kakaoYellow

        addSubview(makarNotiLabel)
        addSubview(makarNotiAddButton)
        addSubview(makarTableView)

        makarNotiAddButton.addTarget(
            self,
            action: #selector(handleMakarAddEvent),
            for: .touchUpInside
        )
    }

    private func setMakarNotiView() {
        backgroundColor = .white
        layer.cornerRadius = 19
        layer.shadowColor = UIColor.lightGray4.cgColor
        layer.shadowOpacity = 0.35
        layer.shadowOffset = .zero
        layer.shadowRadius = 19
    }

    func setMakarAlertController() {
        let okAction = UIAlertAction(title: "추가", style: .destructive) { _ in
            self.selectedMakarTime = self.tempMakarTime
            print(self.selectedMakarTime)
        }
        let cancelAction = UIAlertAction(title: "닫기", style: .cancel)
        let makarPickerView = UIPickerView()

        makarPickerView.delegate = self
        makarPickerView.dataSource = self

        pickerContainerView.view = makarPickerView

        makarAlertController.setValue(
            pickerContainerView,
            forKey: "contentViewController"
        )
        makarAlertController.addAction(okAction)
        makarAlertController.addAction(cancelAction)
    }

    // MARK: Layout
    override func makeConstraints() {
        super.makeConstraints()

        makarNotiLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(21)
            $0.leading.equalToSuperview().inset(20)
        }

        makarNotiAddButton.snp.makeConstraints {
            $0.top.equalToSuperview().inset(25)
            $0.trailing.equalToSuperview().inset(21)
            $0.height.width.equalTo(15)
        }

        makarTableView.snp.makeConstraints {
            $0.top.equalTo(makarNotiLabel.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(85)
        }
    }

    // MARK: Event
    @objc private func handleMakarAddEvent() {
        tapMakarAdd?()
    }
}

extension MakarNotiView: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView,
                    titleForRow row: Int,
                    forComponent component: Int) -> String? {
        return "\(makarTimeArr[row])" + "분 전"
    }

    func pickerView(_ pickerView: UIPickerView,
                    numberOfRowsInComponent component: Int) -> Int {
        return makarTimeArr.count
    }

    func pickerView(_ pickerView: UIPickerView,
                    didSelectRow row: Int,
                    inComponent component: Int) {
        tempMakarTime = makarTimeArr[row]
        print(tempMakarTime)
    }
}

extension MakarNotiView: UITableViewDataSource {
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return 3
    }

    func tableView(_ tableView: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }

    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = makarTableView.dequeueReusableCell(
            withIdentifier: MakarTableViewCell.identifier,
            for: indexPath
        ) as? MakarTableViewCell else { return UITableViewCell() }

        cell.selectionStyle = .none

        return cell
    }
}

extension MakarNotiView: UITableViewDelegate {
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        
    }
}
