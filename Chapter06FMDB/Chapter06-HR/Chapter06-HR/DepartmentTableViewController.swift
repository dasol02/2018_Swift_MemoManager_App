import UIKit

class DepartmentTableViewController: UITableViewController {
    
    var departList : [(departCd: Int, departTitle: String, departAddr: String)]! // 데이터 소스용 멤버 변수
    let departDAO = DepartmentDAO() // SQLite 처리를 담당할 DAO 객체
    
    
    func initUI(){
        // 네비게이션 타이틀용 레이블 속성 설정
        let navTitle = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 60))
        navTitle.numberOfLines = 2
        navTitle.textAlignment = .center
        navTitle.font = UIFont.systemFont(ofSize: 14)
        navTitle.text = "부서 목록 \n"+"총 \(self.departList?.count ?? 0) 개"
        
        // 네비게이션 바 UI 설정
        self.navigationItem.titleView = navTitle
        self.navigationItem.leftBarButtonItem = self.editButtonItem // 편집 버튼 추가
        
        // 셀을 스와이프했을 떄 편집 모드가 되록 설정
        self.tableView.allowsSelectionDuringEditing = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.departList = self.departDAO.find() // 기존 저장된 부서 정보를 가져온다.
        self.initUI()

    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.departList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let rowData = self.departList[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "DEPART_CELL", for: indexPath)
        
        cell.textLabel?.text = rowData.departTitle
        cell.textLabel?.font = UIFont.systemFont(ofSize: 14)
        
        cell.detailTextLabel?.text = rowData.departAddr
        cell.detailTextLabel?.font = UIFont.systemFont(ofSize: 12)
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        
        if editingStyle == .insert {
            
        } else if editingStyle == .delete {
            let departCd = self.departList[indexPath.row].departCd
            if departDAO.remove(departCd: departCd) {
                self.departList.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.fade)
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        
        switch indexPath.row {
        case 0:
            return .delete
        case 1:
            return .insert
        case 2:
            return .none
        default:
            return .none
        }
    }

    
    // MARK: - Action
    
    // 테이블뷰 Add 버튼 메소드
    @IBAction func add(_ sender: Any) {
        // 신규 부서 등록 얼럿창
        self.showAddAlert()
    }
    
    // 신규 부서 등록 얼럿창 제공
    func showAddAlert(){
        
        let alert = UIAlertController(title: "신규 부서 등록", message: "신규 부서를 등록해 주세요", preferredStyle: UIAlertController.Style.alert)
        
        // 부서명 및 주소 입력 테스트 필드 추가
        alert.addTextField { (tf) in
            tf.placeholder = "부서명"
        }
        alert.addTextField { (tf) in
            tf.placeholder = "주소"
        }
        
        alert.addAction(UIAlertAction(title: "취소", style: UIAlertAction.Style.cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "확인", style: UIAlertAction.Style.default, handler: { (_) in
            
            let title = alert.textFields?[0].text
            let addr = alert.textFields?[1].text
            
            // 부서 등록
            if self.departDAO.create(title: title!, addr: addr!) {
                // 뷰 갱신
                self.departList = self.departDAO.find()
                self.tableView.reloadData()
                let navTitle = self.navigationItem.titleView as! UILabel
                navTitle.text = "부서 목록 \n"+"총 \(self.departList?.count ?? 0) 개"
            }
        }))
        
        self.present(alert, animated: false, completion: nil)
        
    }
    
}
