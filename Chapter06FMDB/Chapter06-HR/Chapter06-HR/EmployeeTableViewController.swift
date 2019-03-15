import UIKit

class EmployeeTableViewController: UITableViewController{
    var empList : [EmployeeVO]!
    var empDAO = EmployeeDAO()
    var loadingImg: UIImageView!
    var bgCircle: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.empList = self.empDAO.find()
        self.initUI()
        
        self.refreshControl = UIRefreshControl()
//        self.refreshControl?.attributedTitle = NSAttributedString(string: "당겨서 새로고침")
        self.refreshControl?.addTarget(self, action: #selector(pullToRefresh(_:)), for: UIControl.Event.valueChanged)
        
        self.refreshControl?.tintColor = UIColor.clear
        self.loadingImg = UIImageView(image: UIImage(named: "refresh"))
        self.loadingImg.center.x = (self.refreshControl?.frame.width)! / 2
        self.refreshControl?.addSubview(self.loadingImg)
        
        self.bgCircle = UIView()
        self.bgCircle.backgroundColor = UIColor.yellow
        self.bgCircle.center.x = (self.refreshControl?.frame.width)! / 2
       
        
        self.refreshControl?.addSubview(bgCircle)
        self.refreshControl?.bringSubviewToFront(self.loadingImg)
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let distance = max(0.0, -(self.refreshControl?.frame.origin.y)!)
        self.loadingImg.center.y = distance/2
        let ts = CGAffineTransform(rotationAngle: CGFloat(distance/20))
        self.loadingImg.transform = ts
        self.bgCircle.center.y = distance / 2
        
        NSLog("distance : \(distance)")
    }
    
    override func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        self.bgCircle.frame.size.width = 0
        self.bgCircle.frame.size.height = 0
    }
    
    
    @objc func pullToRefresh(_ sender: Any){
        self.empList = self.empDAO.find()
        self.tableView.reloadData()
        self.refreshControl?.endRefreshing()
        
        let distance = max(0.0, -(self.refreshControl?.frame.origin.y)!)
        UIView.animate(withDuration: 0.5) {
            self.bgCircle.frame.size.width = 80
            self.bgCircle.frame.size.height = 80
            self.bgCircle.center.x = (self.refreshControl?.frame.width)! / 2
            self.bgCircle.center.y = distance / 2
            self.bgCircle.layer.cornerRadius = (self.bgCircle?.frame.size.width)! / 2
        }
    }

    
    func initUI() {
        
        let navTitle = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 60))
        navTitle.numberOfLines = 2
        navTitle.textAlignment = .center
        navTitle.font = UIFont.systemFont(ofSize: 14)
        navTitle.text = "사원 목록 \n"+"총 \(self.empList?.count ?? 0) 명"
        
        self.navigationItem.titleView = navTitle
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.empList?.count ?? 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let rowData = self.empList[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "EMP_CELL", for: indexPath)
        
        cell.textLabel?.text = rowData.empName + "(\(rowData.stateCd.desc()))"
        cell.textLabel?.font = UIFont.systemFont(ofSize: 14)
        
        cell.detailTextLabel?.text = rowData.departTitle
        cell.detailTextLabel?.font = UIFont.systemFont(ofSize: 12)
        
        return cell
    }

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        
        if editingStyle == .delete {
            let empCd = self.empList[indexPath.row].empCd
            
            if empDAO.remove(empCd: empCd) {
                self.empList.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
            
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    
    
    // MARK: - Action
    
    // 부서 등록 함수
    @IBAction func add(_ sender: Any) {
        self.showAddAlert()
    }
    
    @IBAction func editing(_ sender: Any) {
       self.cellEditingAction(sender) // 셀 수정 이벤트
    }
    
    
    
    
    // MARK: - PRIVITE
    
    func cellEditingAction(_ sender:Any) {
        if self.isEditing == false {
            self.setEditing(true, animated: true)
            (sender as? UIBarButtonItem)?.title = "Done"
        } else {
            self.setEditing(false, animated: true)
            (sender as? UIBarButtonItem)?.title = "Edit"
        }
    }
    
    // 신규 부서 등록 얼럿창 제공
    func showAddAlert(){
        
        let alert = UIAlertController(title: "사원 등록", message: "등록할 사원 정보를 입력해 주세요", preferredStyle: UIAlertController.Style.alert)
        
        // 부서명 및 주소 입력 테스트 필드 추가
        alert.addTextField { (tf) in
            tf.placeholder = "사원명"
        }
        
        // 피커뷰 생성
        let pickerVC = DepartPickerVC()
        alert.setValue(pickerVC, forKey: "contentViewController")
        
        // 결과 이벤트 생성
        alert.addAction(UIAlertAction(title: "취소", style: UIAlertAction.Style.cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "확인", style: UIAlertAction.Style.default, handler: { (_) in
            // 사원 정보 지정
            var param = EmployeeVO()
            param.departCd = pickerVC.selectDepartCd
            param.empName = (alert.textFields?[0].text)!
            param.stateCd = EmpStateType.ING
            
            // 가입일 지정 (오늘 날짜)
            let df = DateFormatter()
            df.dateFormat = "yyyy-MM-dd"
            param.joinDate = df.string(from: Date())
            
            
            // DB 사원 등록
            if self.empDAO.create(param: param){
                
                // 뷰 갱신
                self.empList = self.empDAO.find()
                self.tableView.reloadData()
                
                // 내비게이션 타이틀 지정
                let navTitle = self.navigationItem.titleView as! UILabel
                navTitle.text = "사원 목록 \n"+"총 \(self.empList?.count ?? 0) 명"
            }
        }))
        
        self.present(alert, animated: false, completion: nil)
        
    }
}
