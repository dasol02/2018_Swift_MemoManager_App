import UIKit

class ListTableViewController: UITableViewController {

    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var gender: UISegmentedControl!
    @IBOutlet weak var married: UISwitch!
    
    // 이름 필드 선택시
    @IBAction func edit(_ sender: UITapGestureRecognizer) {
        // 이름 수정
        self.nameEdit()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 초기화면 생성시 저장되어 있는 값 출력
        let plist = UserDefaults.standard
        if let name: String = plist.string(forKey: "name"){
            self.name.text = name
        }
        
        self.gender.selectedSegmentIndex = plist.integer(forKey: "gender")
        self.married.isOn = plist.bool(forKey: "married")
        
    }
    
    // MARK: Action Method
    @IBAction func changeGender(_ sender: UISegmentedControl) {
        let value = sender.selectedSegmentIndex // 0이면 남자, 1이면 여자
        
        let plist = UserDefaults.standard // 기본 저장소 객체를 가져온다.
        plist.set(value, forKey: "gender") // "gender"라는 키로 값을 저장한다.
        plist.synchronize() // 동기화
        
        // LOG
        let valueString = plist.string(forKey: "gender")
        print("UserDefaults Data : gender = '\(String(describing: valueString))'")
    }
    
    
    @IBAction func changeMarried(_ sender: UISwitch) {
        
        let value = sender.isOn // turue 기혼, false 이혼
        
        let plist = UserDefaults.standard // 기본 저장소 객체를 가져온다.
        plist.set(value, forKey: "married") // married 키값으로 저장
        plist.synchronize() // 동기화
        
        // LOG
        let valueString = plist.string(forKey: "married")
        print("UserDefaults Data : married = '\(String(describing: valueString))'")
    }
    
    
    // MARK : TableView DataSource
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 0 { // 첫번쨰 셀이 클릭 되었을 때에만
            self.nameEdit() // 이름 수정
        }
    }
    
    
    // 이름 필드 입력
    func nameEdit(){
        let alert = UIAlertController(title: nil, message: "이름을 입력하세요", preferredStyle: UIAlertController.Style.alert)
        
        // 입력 필드 추가
        alert.addTextField { (textfield : UITextField) in
            textfield.text = self.name.text // name 레이블의 텍스트를 입력폼에 기본값으로 넣어준다.
        }
        
        // 버튼 및 액션 추가
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { (UIAlertAction) in
            // 사용자가 OK 버튼을 누르면 입력 필드에 입력된 값을 저장한다.
            let value = alert.textFields?[0].text   // alert View 텍스트 필드
            let plist = UserDefaults.standard   // 기본저장소 가져온다.
            plist.set(value, forKey: "name") // name키값으로 이름 저장
            plist.synchronize() // 동기화
            self.name.text = value
            
            // LOG
            let valueString = plist.string(forKey: "name")
            print("UserDefaults Data : name = '\(String(describing: valueString))'")
        }))
        
        // 알림창을 띄운다.
        self.present(alert, animated: false, completion: nil)
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
