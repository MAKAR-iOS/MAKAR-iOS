//
//  NotificationViewController.swift
//  MAKAR
//
//  Created by 박지윤 on 2023/12/25.
//

import UIKit
import Toast

class NotificationViewController: BaseViewController {
   
    let makarTimeArr = [5, 10, 15, 20, 25, 30]
    var tempMakarTime = 5
    var selectedMakarTime: [Int] = []
    let getOffStationArr = ["없음", "1전 역", "2전 역", "3전 역"]
    var selectedGetOffStation = "없음"

    // MARK: UI Components
    private let makarNotiView = UIView().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 19
        $0.layer.shadowColor = UIColor.lightGray5.cgColor
        $0.layer.shadowOpacity = 0.35
        $0.layer.shadowOffset = .zero
        $0.layer.shadowRadius = 19
    }

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

    private let makarAlertController = UIAlertController(
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

    private let getOffNotiView = UIView().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 19
        $0.layer.shadowColor = UIColor.lightGray5.cgColor
        $0.layer.shadowOpacity = 0.35
        $0.layer.shadowOffset = .zero
        $0.layer.shadowRadius = 19
    }

    private let getOffNotiLabel = UILabel().then {
        $0.text = "하차 알림"
        $0.textColor = .black
        $0.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
    }

    private let getOffNotiAddButton = BaseButton().then {
        $0.setTitle("없음", for: .normal)
        $0.setTitleColor(UIColor.lightGray, for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        $0.semanticContentAttribute = .forceRightToLeft
        $0.imageEdgeInsets = .init(top: 0, left: 10, bottom: 0, right: 0)
        $0.setImage(MakarButton.moreBottomButton, for: .normal)
    }

    // MARK: Environment
    private let router = BaseRouter()

    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setDropDown()
        setMakarTableViewHidden()
        setMakarAlertController()

        makarTableView.dataSource = self
        makarTableView.delegate = self

        view.backgroundColor = .background
        router.viewController = self
        
        makarNotiAddButton.addTarget(self, action: #selector(tapMakarNotiAdd), for: .touchUpInside)
    }
    
    @objc private func tapMakarNotiAdd() {
        present(makarAlertController, animated: true)
    }

    private func setMakarTableViewHidden() {
        if selectedMakarTime.isEmpty {
            makarTableView.isHidden = true
            makarEmptyLabel.isHidden = false
        } else {
            makarTableView.isHidden = false
            makarEmptyLabel.isHidden = true
        }
    }

    private func setMakarAlertController() {
        let okAction = UIAlertAction(title: "추가", style: .destructive) { [self] _ in
            if selectedMakarTime.contains(tempMakarTime) {
                DispatchQueue.main.async {
                    self.view.makeToast(" 이미 설정된 알림입니다. ", duration: 1.0, position: .bottom)
                }
            } else {
                selectedMakarTime.append(tempMakarTime)
                print(selectedMakarTime)
                setMakarTableViewHidden()
                makarTableView.reloadData()
            }
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

    // MARK: Configuration
    override func configureSubviews() {
        super.configureSubviews()

        view.addSubview(makarNotiView)
        view.addSubview(getOffNotiView)

        makarNotiView.addSubview(makarNotiLabel)
        makarNotiView.addSubview(makarEmptyLabel)
        makarNotiView.addSubview(makarNotiAddButton)
        makarNotiView.addSubview(makarTableView)

        getOffNotiView.addSubview(getOffNotiLabel)
        getOffNotiView.addSubview(getOffNotiAddButton)
    }

    // MARK: Layout
    override func makeConstraints() {
        super.makeConstraints()

        makarNotiView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(155)
        }

        getOffNotiView.snp.makeConstraints {
            $0.top.equalTo(makarNotiView.snp.bottom).offset(26)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(54)
        }

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

        makarTableView.snp.makeConstraints {
            $0.top.equalTo(makarNotiLabel.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(80)
        }

        getOffNotiLabel.snp.makeConstraints {
            $0.centerY.equalTo(getOffNotiView.snp.centerY)
            $0.leading.equalTo(getOffNotiView).inset(20)
        }

        getOffNotiAddButton.snp.makeConstraints {
            $0.centerY.equalTo(getOffNotiView.snp.centerY)
            $0.trailing.equalTo(getOffNotiView).inset(22)
            $0.height.equalTo(20)
            $0.width.equalTo(60)
        }
    }

    private func setDropDown() {
        let actionClosure = { [self] (action: UIAction) in
            selectedGetOffStation = action.title
            print(selectedGetOffStation)
        }

        var menuChildren: [UIMenuElement] = []
        for station in getOffStationArr {
            menuChildren.append(UIAction(title: station, handler: actionClosure))
        }

        getOffNotiAddButton.menu = UIMenu(options: .displayInline, children: menuChildren)
        getOffNotiAddButton.showsMenuAsPrimaryAction = true
        getOffNotiAddButton.changesSelectionAsPrimaryAction = true

    }
}

extension NotificationViewController: UIPickerViewDataSource, UIPickerViewDelegate {
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
    }
}

extension NotificationViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectedMakarTime.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = makarTableView.dequeueReusableCell(
            withIdentifier: MakarTableViewCell.identifier,
            for: indexPath
        ) as? MakarTableViewCell else { return UITableViewCell() }

        cell.tapDeleteNotiButton = {[weak self] in
            guard let self else { return }
            
            selectedMakarTime.remove(at: indexPath.row)
            print(selectedMakarTime)
            setMakarTableViewHidden()
            makarTableView.reloadData()
        }

        cell.makarNameLabel.text = "막차 알림 " + "\(indexPath.row + 1)"
        cell.makarTimeLabel.text = "\(selectedMakarTime[indexPath.row])" + "분 전"
        cell.selectionStyle = .none

        return cell
    }

    func tableView(_ tableView: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
}
