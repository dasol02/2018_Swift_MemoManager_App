import UIKit

class ListTableViewController: UITableViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var gender: UISegmentedControl!
    @IBOutlet weak var married: UISwitch!
    @IBOutlet weak var account: UITextField! // 계정정보
    
    
    // Piker Info 정의
    var accontList = ["qulpro@naver.com",
                      "webmaster@rubypaper.co.kr",
                      "abc1@gmail.com",
                      "abc2gmail.com",
                      "abc3gmail.com",]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let picker = UIPickerView()
        picker.delegate = self
        self.account.inputView = picker
        
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
    
    
    // 이름 필드 선택시
    @IBAction func edit(_ sender: UITapGestureRecognizer) {
        // 이름 수정
        self.nameEdit()
    }
    
    
    // MARK: UIPickerView DataSource
    // 컴포넌트의 개수
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1;
    }
    
    // 컴포넌트의 목록 길이
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.accontList.count;
    }
    
    // 컴포넌트의 목록의 해당 내용
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.accontList[row]
    }
    
    // 컴포넌트의 클릭시 이벤트
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        // 피커뷰 내용 텍스트필드에 입력
        let accountSting = self.accontList[row]
        self.account.text = accountSting
        
        // 피커뷰 종료
        self.view.endEditing(true)
    }
    
   
    
    
    // MARK : TableView DataSource
    // Super 오버라이드
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 0 { // 첫번쨰 셀이 클릭 되었을 때에만
            self.nameEdit() // 이름 수정
        }
    }
    
    
    // MARK: PRIVATE
    // 이름 필드 입력
    private func nameEdit(){
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

}
