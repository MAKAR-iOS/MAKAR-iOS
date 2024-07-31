//
//  MyPageViewController.swift
//  MAKAR
//
//  Created by 박지윤 on 2023/12/25.
//

import UIKit

class MyPageViewController: BaseViewController {
    
    // MARK: Constants
    private enum Metric {
        static let myPageViewHeight = 90
    }

    // MARK: UI Components
    private let myPageView = MyPageView()
    let myPageTableView = UITableView(frame: .zero, style: .grouped)
    let myPageTableViewCellList : [[String]] = [["자주 가는 역 설정", "즐겨찾는 경로 설정", "푸시 알림"], ["서비스 이용 약관", "개인 정보 처리 방침"], ["로그아웃", "회원 탈퇴"]]
    let myPageTableViewHeaderList : [String] = ["설정", "앱 정보", "계정 관리"]

    // MARK: Environment
    private let router = BaseRouter()

    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        router.viewController = self
        view.backgroundColor = .background
        setTableView()
    }

    // MARK: Configuration
    override func configureSubviews() {
        super.configureSubviews()

        view.addSubview(myPageView)
    }

    // MARK: Layout
    override func makeConstraints() {
        super.makeConstraints()

        myPageView.snp.makeConstraints{
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(Metric.myPageViewHeight)
        }
    }

    // MARK: NavigationBar
    private func setNavigationBar(){
        navigationItem.title = "마이페이지"
        navigationController?.navigationBar.prefersLargeTitles = false
    }
}

// MARK: TableView
extension MyPageViewController : UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myPageTableViewCellList[section].count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myPageTableViewCell") ?? UITableViewCell(style: .default, reuseIdentifier: "myPageTableViewCell")
        cell.textLabel?.text = myPageTableViewCellList[indexPath.section][indexPath.row]
        cell.textLabel?.font = UIFont.systemFont(ofSize: 15)
        cell.textLabel?.textColor = .darkGray
        cell.backgroundColor = .background
        cell.accessoryType = .disclosureIndicator
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                //자주 가는 역 설정
                navigationController?.pushViewController(FavoriteStationViewController(), animated: true)
            case 1:
                //즐겨찾는 경로 설정
                navigationController?.pushViewController(FavoriteRouteViewController(), animated: true)
            case 2:
                //푸시 알림 설정
                navigationController?.pushViewController(PushAlarmViewController(), animated: true)
            default:
                break
            }
        case 1:
            if(indexPath.row == 0){
                //서비스 이용 약관
            } else{
                //개인정보 처리 방침
            }
        case 2:
            if(indexPath.row == 0){
                showLogoutAlert()
            } else{
                showWithdrawalAlert()
            }
        default:
            break
        }
    }
    
    //header
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return myPageTableViewHeaderList[section]
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    //footer
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView(frame: .zero)
        footerView.backgroundColor = .divider
        return footerView
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if(section == 2){
            return 0
        } else {
            return 3
        }
    }
        
    func setTableView(){
        view.addSubview(myPageTableView)

        myPageTableView.backgroundColor = .background
        myPageTableView.separatorStyle = .none
        
        myPageTableView.snp.makeConstraints{
            $0.top.equalTo(myPageView.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        myPageTableView.dataSource = self
        myPageTableView.delegate = self
    }
}

    // MARK: Alert
extension MyPageViewController {
    private func showLogoutAlert() {
        let logoutAlert = UIAlertController(title: "로그아웃하시겠어요?", message: "", preferredStyle: .alert)
        logoutAlert.addAction( UIAlertAction(title: "로그아웃", style: .destructive, handler: { [self] _ in
            postSignOut()
        }))
        logoutAlert.addAction(UIAlertAction(title: "취소", style: .cancel))
        present(logoutAlert, animated: true)
    }
    
    private func showWithdrawalAlert(){
        let withdrawalAlert = UIAlertController(title: "정말 탈퇴하시겠어요?", message: "이 동작은 취소할 수 없어요", preferredStyle: .alert)
        withdrawalAlert.addAction( UIAlertAction(title: "탈퇴하기", style: .destructive, handler: {_ in
           // TODO: 회원탈퇴 기능 구현
        }))
        withdrawalAlert.addAction(UIAlertAction(title: "취소", style: .cancel))
        present(withdrawalAlert, animated: true)
    }
}

extension MyPageViewController {
    // MARK: Network
    private func postSignOut() {
        print("🚇 postSignOut called")
        NetworkService.shared.auth.postSignOut()
        { [self] result in
            switch result {
            case .success(let response):
                guard let data = response as? SignOutAuthResponse else { return }
                print("🎯 postSignOut success: " + "\(data)")
                router.dismissViewController()
            case .requestErr(let errorResponse):
                dump(errorResponse)
                guard let data = errorResponse as? ErrorResponse else { return }
                print(data)
            case .serverErr:
                print("serverErr")
            case .networkFail:
                print("networkFail")
            case .pathErr:
                print("pathErr")
            }
        }
    }
}
