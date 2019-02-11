import UIKit

class ListTableViewController: UITableViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var gender: UISegmentedControl!
    @IBOutlet weak var married: UISwitch!
    @IBOutlet weak var account: UITextField! // 계정정보
    
    
    // Piker Info 정의 (DUMMY)
    var accontList = ["qulpro@naver.com",
                      "webmaster@rubypaper.co.kr",
                      "abc1@gmail.com",
                      "abc2gmail.com",
                      "abc3gmail.com",]

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 피커뷰 생성
        self.initPickerView()
        
        // 초기화면 생성시 저장되어 있는 값 출력
        let plist = UserDefaults.standard
        if let name: String = plist.string(forKey: "name"){
            self.name.text = name
        }
        

        
        self.gender.selectedSegmentIndex = plist.integer(forKey: "gender")
        self.married.isOn = plist.bool(forKey: "married")
        
    }
    
    
    // MARK: Action Method
    
    // 피커뷰 New 버튼 클릭 (계정 추가)
    @objc func addNewAcction(_ sender: Any){
        
        self.view.endEditing(true)
        
        let alert = UIAlertController(title: "새 계정을 입력하세요", message: nil, preferredStyle: UIAlertController.Style.alert)
        
        // 입력폼 추가
        alert.addTextField { (textField) in
            textField.placeholder = "ex) abc@gmail.com"
        }
        
        // 버튼 및 액션 정의
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { (action) in
            
            // 텍스트 필드 내용 있을 경우
            if let account = alert.textFields?[0].text{
                
                // 리스트추가 및 계정 내용 입력
                self.accontList.append(account)
                self.account.text = account
            }
            
        }))
        
        self.present(alert, animated: false, completion: nil)
        
    }
    
    // 피커뷰 Done버튼 클릭시
    @objc func pickerDone(){
        self.view.endEditing(true)
    }
    

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
        // self.view.endEditing(true)
        // 피커뷰 스크롤 종료시 이벤트 호출로 인한 메서드 주석처리
    }
    
   
    
    
    // MARK : TableView DataSource
    // Super 오버라이드
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 0 { // 첫번쨰 셀이 클릭 되었을 때에만
            self.nameEdit() // 이름 수정
        }
    }
    
    
    // MARK: PRIVATE
    
    // 피커뷰 및 툴바 생성
    private func initPickerView(){
        // 피커뷰 생성
        let picker = UIPickerView()
        picker.delegate = self
        self.account.inputView = picker
        
        // 액세서리 생성
        let toolbar = UIToolbar()
        toolbar.frame = CGRect(x: 0, y: 0, width: 0, height: 35)
        toolbar.barTintColor = UIColor.lightGray
        
        // 텍스트필드 입력창 액세서리 추가
        self.account.inputAccessoryView = toolbar
        
        // 바버튼 아이템 생성
        let barButton = UIBarButtonItem()
        barButton.title = "Done"
        barButton.target = self
        barButton.action = #selector(pickerDone)
        
        // 좌측여백 생성
        let flexSoace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        
        
        // 새로운 계정 생성 버튼
        let new = UIBarButtonItem()
        new.title = "New"
        new.target = self
        new.action = #selector(addNewAcction(_:))
        
        // 툴바에 버튼 추가
        toolbar.setItems([new,flexSoace,barButton], animated: true)
    }
    
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
