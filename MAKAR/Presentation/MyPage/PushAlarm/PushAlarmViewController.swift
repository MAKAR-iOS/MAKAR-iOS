//
//  PushAlarmViewController.swift
//  MAKAR
//
//  Created by 김다은 on 1/11/24.
//

import UIKit
class PushAlarmViewController : BaseViewController {
    
    // MARK: UI Components
    let pushAlarmTableView = UITableView(frame: .zero, style: .grouped)
    let pushAlarmTableViewCellList : [[String]] = [["전체 알림"], ["막차 알림", "하차 알림"]]
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()

        view.backgroundColor = .background
        setTableView()
    }
    
    // MARK: NavigationBar
    private func setNavigationBar(){
        navigationItem.title = "푸시 알림"
    }
}

    // MARK: TableView
extension PushAlarmViewController : UITableViewDelegate, UITableViewDataSource {
    //cell
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pushAlarmTableViewCellList[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "pushAlarmTableViewCell") ?? UITableViewCell(style: .default, reuseIdentifier: "pushAlarmTableViewCell")
        cell.textLabel?.text = pushAlarmTableViewCellList[indexPath.section][indexPath.row]
        cell.textLabel?.font = UIFont.systemFont(ofSize: 16)
        cell.textLabel?.textColor = .darkGray
        cell.backgroundColor = .background
        cell.accessoryView = UISwitch()
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(indexPath.section == 0){
           //전체 알림
        } else {
            if(indexPath.row == 0){
                //막차 알림
            } else {
                //하차 알림
            }
        }
    }
    
    //header
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    
    //footer
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView(frame: .zero)
        footerView.backgroundColor = .divider
        return footerView
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if(section == 0){
            return 3
        } else {
            return 0
        }
    }
    
    func setTableView(){
        view.addSubview(pushAlarmTableView)

        pushAlarmTableView.backgroundColor = .background
        pushAlarmTableView.separatorStyle = .none
        pushAlarmTableView.sectionHeaderHeight = 0
        
        pushAlarmTableView.snp.makeConstraints{
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        pushAlarmTableView.dataSource = self
        pushAlarmTableView.delegate = self
    }
}
