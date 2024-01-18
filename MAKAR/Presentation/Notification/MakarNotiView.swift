//
//  MakarNotiView.swift
//  MAKAR
//
//  Created by 박지윤 on 2024/01/08.
//

import UIKit

class MakarNotiView: BaseView {

    let makarTimeArr = [5, 10, 15, 20, 25, 30]
    var tempMakarTime = [5]
    var selectedMakarTime = [5]
//    var selectedMakarTime: [Int] = []

    // MARK: UI Components
    private let makarNotiLabel = UILabel().then {
        $0.text = "막차 알림"
        $0.textColor = .black
        $0.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
    }

    private let makarNotiAddButton = BaseButton().then {
        $0.setImage(MakarButton.addButton, for: .normal)
    }

    private let makarEmptyLabel = UILabel().then {
        $0.text = "설정한 막차 알림이 없습니다."
        $0.textColor = .lightGray
        $0.textAlignment = .center
        $0.font = UIFont.systemFont(ofSize: 14, weight: .regular)
    }

    var makarAlertController = UIAlertController(
        title: "막차 알림",
        message: nil,
        preferredStyle: .alert
    )

    private let makarPickerView = UIPickerView()
    private let pickerContainerView = UIViewController()

    let makarTableView = UITableView().then {
        $0.separatorStyle = .none
        $0.register(
            MakarTableViewCell.self,
            forCellReuseIdentifier: MakarTableViewCell.identifier
        )
    }

    // MARK: Properties
    var tapMakarAdd: (() -> Void)?
    var tapMakarNotiAdd: (() -> Void)?

    // MARK: Configuration
    override func configureSubviews() {
        super.configureSubviews()

        setMakarNotiView()
        setMakarAlertController()

        makarTableView.dataSource = self
        makarTableView.delegate = self

        addSubview(makarNotiLabel)
        addSubview(makarNotiAddButton)
        addSubview(makarEmptyLabel)
//        addSubview(makarTableView)

        makarNotiAddButton.addTarget(
            self,
            action: #selector(handleMakarAddEvent),
            for: .touchUpInside
        )
    }

    func setMakarNotiView() {
        backgroundColor = .white
        layer.cornerRadius = 19
        layer.shadowColor = UIColor.lightGray4.cgColor
        layer.shadowOpacity = 0.35
        layer.shadowOffset = .zero
        layer.shadowRadius = 19

        if selectedMakarTime.isEmpty {
            makarTableView.isHidden = true
            makarEmptyLabel.isHidden = false
        } else {
            makarTableView.isHidden = false
            makarEmptyLabel.isHidden = true
        }

        makarTableView.reloadData()
    }

    func setMakarAlertController() {
        let okAction = UIAlertAction(title: "추가", style: .destructive) { [self] _ in
//            selectedMakarTime.append(tempMakarTime)
            print(selectedMakarTime)
            print(#function, #line, "")
            selectedMakarTime += tempMakarTime
//            setMakarNotiView()
            tapMakarNotiAdd?()
            makarTableView.reloadData()
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

        makarEmptyLabel.snp.makeConstraints {
            $0.top.equalTo(makarNotiLabel.snp.bottom).offset(47)
            $0.centerX.equalToSuperview()
        }

//        makarTableView.snp.makeConstraints {
//            $0.top.equalTo(makarNotiLabel.snp.bottom).offset(16)
//            $0.leading.trailing.equalToSuperview()
//            $0.height.equalTo(85)
//        }
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
        tempMakarTime[0] = makarTimeArr[row]
    }
}

extension MakarNotiView: UITableViewDataSource {
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return selectedMakarTime.count
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

        cell.tapDeleteNotiButton = {[weak self] in
            guard let self else { return }
            
            selectedMakarTime.remove(at: indexPath.row)
            print(selectedMakarTime)
            makarTableView.reloadData()
        }

        cell.makarNameLabel.text = "막차 알림 " + "\(indexPath.row + 1)"
        cell.makarTimeLabel.text = "\(selectedMakarTime[indexPath.row])" + "분 전"
        cell.selectionStyle = .none

        return cell
    }
}

extension MakarNotiView: UITableViewDelegate {
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        
    }
}
