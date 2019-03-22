import UIKit

class MemoTableViewController: UITableViewController, UISearchBarDelegate {
    @IBOutlet weak var searchBar: UISearchBar!
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    lazy var dao = MemoDAO()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.enablesReturnKeyAutomatically = false
        
        // 사이드바 라이브러리 객체 선언
        if let revealVC = self.revealViewController(){
            let barBtn = UIBarButtonItem()
            barBtn.image = UIImage(named: "sidemenu.png")
            
            // 이벤트 연결
            barBtn.target = revealVC
            barBtn.action = #selector(revealVC.revealToggle(_:))
            
            // 버튼 추가
            self.navigationItem.leftBarButtonItem = barBtn
            
            // 제스처 추가
            self.view.addGestureRecognizer(revealVC.panGestureRecognizer())
        }
        
    }
    
    // 화면이 돌아왔을때 테이블뷰의 데이터를 갱신한다.
    override func viewWillAppear(_ animated: Bool) {
        
        let ud = UserDefaults.standard
        if ud.bool(forKey: UserInfoKey.tutorial) == false {
            let vc = self.instanceTutorialVC(name: "MasterVC")
            self.present(vc!, animated: true, completion: nil)
            return
        }
        
        self.appDelegate.memolist = self.dao.fetch()
        
        self.tableView.reloadData()
    }

    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = self.appDelegate.memolist.count
        return count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // memolist 배열 데이터에서 주어진 행에 맞는 데이터를 꺼낸다.
        let row = self.appDelegate.memolist[indexPath.row]
        
        // 이미지 속성이 비어 있을 경우 "MemoCell", 아니면 "MemoCellWithImage"
        let cellID = row.image == nil ? "MemoCell" : "MemoCellWithImage"
        
        // 재사용 큐로부터 프로토타입 셀의 인스턴스를 전달 받는다.
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as? MemoTableViewCell else {
            // 옵셔널 변경 실패 할 경우
            return UITableViewCell()
        }
        
        // MemoCell의 내용을 구선한다.
        cell.subject?.text = row.title
        cell.contents?.text = row.contents
        cell.img?.image = row.image

        // Date 타입의 날짜를 yyyy-MM-dd HH:mm:ss 포맷에 맞게 변경한다.
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        cell.regdate?.text = formatter.string(from: row.regdate!)
        
        // cell 객체를 리턴한다.
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // memolist 배열에서 선택된 행에 맞는 데이터를 꺼낸다.
        let row = self.appDelegate.memolist[indexPath.row]
        
        // 상세화면의 인스턴스를 생성
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "MemoRead") as? MemoReadViewController else {
            return
        }
        
        // 값을 전달한 다음, 상세화면으로 이동한다.
        vc.param = row
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        let data = self.appDelegate.memolist[indexPath.row]
        
        if dao.delete(data.objectID!) {
            self.appDelegate.memolist.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.fade)
        }
    }
    
    // MARK: - SearchBar Delegate
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        let keyword = searchBar.text
        
        self.appDelegate.memolist = self.dao.fetch(keyword: keyword)
        self.tableView.reloadData()
        
    }
}


