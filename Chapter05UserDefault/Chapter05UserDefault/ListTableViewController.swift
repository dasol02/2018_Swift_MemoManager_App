import UIKit

class ListTableViewController: UITableViewController {

    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var gender: UISegmentedControl!
    @IBOutlet weak var married: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()


    }
    
    // MARK: action method
    
    @IBAction func changeGender(_ sender: UISegmentedControl) {
        
    }
    
    
    @IBAction func changeMarried(_ sender: UISwitch) {
        
    }
    
    
    // MARK: 스토리보드의 화면 객체를 사용(Static) 상위 테이블뷰 클래스의 메서드 오버라이드 사용
    // MARK: - Table view data source
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        return super.numberOfSections(in: tableView)
//    }
//
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//
//        return super.tableView(tableView, numberOfRowsInSection: section)
//    }

}
