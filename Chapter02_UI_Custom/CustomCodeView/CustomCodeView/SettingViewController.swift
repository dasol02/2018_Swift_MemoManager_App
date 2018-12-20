import UIKit

/**
 * 화면 객체를 코드로 생성 (스토리보드를 사용하지 않고)
 */
class SettingViewController: UIViewController {
    
    var paramEmail : UITextField! // 이메일 입력 필드
    var paramUpdate : UISwitch! // 스위치 버튼 객체
    var paramInterval : UIStepper! //  스테퍼 생성
    var textUpdate : UILabel! // 스위치 버튼 라벨
    var textInterval : UILabel! // 스테퍼 버튼 라벨

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 네비게이션 타이틀 설정
        self.navigationItem.title = "설정"
        
        // 네비게이션 아이템 추가
        let submitBTN = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.compose, target: self, action: #selector(submitNextPage(_:)))
        self.navigationItem.rightBarButtonItem = submitBTN
        
        
        self.createLabel()          // 라벨 생성
        self.createTextField()      // 텍스트 필드 생성
        self.createSwitchButton()   // 스위치 버튼 생성
        self.createSwitchLabel()    // 스위치 버튼 라벨 생성
        self.createStepper()        // 스테퍼 버튼 생성
        self.createIntervalLabel()  // 스테퍼 버튼 라벨 생성
        
        self.setAction()            // 버튼 이벤트 연결
       
        let color = self.UIColorFromRGB(rgbValue: 0xDFDFDF)  // 헥사코드 색상 반환 : 0xDFDFDF
        //        self.createFontLabel()    // 폰트 로그 테스트
        print(color)
    }

// MARK: - ACTION
    // 다음 화면 이동
    @objc func submitNextPage(_ sender : Any){
        let rvc = ReadViewController()
        rvc.pEmail = self.paramEmail.text
        rvc.pUpdate = self.paramUpdate.isOn
        rvc.pInterval = self.paramInterval.value
        
        self.navigationController?.pushViewController(rvc, animated: true)
    }
    
    // 스위치 버튼 액션
    @objc func presentUpdatevalue(_ sender : UISwitch){
        self.textUpdate.text = (sender.isOn == true ? "갱신함" : "갱신하지 않음")
    }
    
    // 스테퍼 버튼 액션
    @objc func presentIntervalvalue(_ sender : UIStepper){
        self.textInterval.text = ("\(Int(sender.value) )분만다")
    }
    
// MARK: -  PRIVATE
    /**
     * 버튼 이벤트 연결
     */
    func setAction(){
        self.paramUpdate.addTarget(self, action: #selector(presentUpdatevalue(_:)), for: .valueChanged)
        self.paramInterval.addTarget(self, action: #selector(presentIntervalvalue(_:)), for: .valueChanged)
    }
    
    
    /**
     * 헥사코드 색상 반환 : 0xDFDFDF
     * return : UIColor
     */
    func UIColorFromRGB(rgbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }

    /**
     * 폰트 로그 테스트
     */
    func createFontLOG(){
        // 설정 가능한 폰트 출력
        let fonts = UIFont.familyNames
        
        for f in fonts{
            print("\(f)")
        }
        print("========================")
        
        
        // 상세 폰트 출력
        //        let labelFont = UIFont.fontNames(forFamilyName: "Menlo")
        let labelFont = UIFont.fontNames(forFamilyName: "Chalkboard SE")
        
        for f in labelFont{
            print("\(f)")
        }
        print("========================")
        
    }
// MARK: -  CREATE VIEW ITEM
    
    /**
     * 스테퍼 버튼 라벨 생성
     */
    func createIntervalLabel(){
        self.textInterval = UILabel()
        self.textInterval.frame = CGRect(x: 250, y: 200, width: 100, height:30)
        self.textInterval.font = UIFont.systemFont(ofSize: 12)
        self.textInterval.textColor = UIColor.red
        self.textInterval.text = "0분마다"
        
        self.view.addSubview(self.textInterval)
    }
    
    /**
     * 스위치 버튼 라벨 생성
     */
    func createSwitchLabel(){
        self.textUpdate = UILabel()
        self.textUpdate.frame = CGRect(x: 250, y: 150, width: 100, height:30)
        self.textUpdate.font = UIFont.systemFont(ofSize: 12)
        self.textUpdate.textColor = UIColor.red
        self.textUpdate.text = "갱신함"
        
        self.view.addSubview(self.textUpdate)
    }

    /**
     * 스테퍼 생성
     */
    func createStepper(){
        self.paramInterval = UIStepper()
        self.paramInterval.frame = CGRect(x: 120, y: 200, width: 50, height: 30)
        self.paramInterval.minimumValue = 0 // 최소값
        self.paramInterval.maximumValue = 100 // 최대값
        self.paramInterval.stepValue = 1 // 값 변경 단위
        self.paramInterval.value = 0 // 초기값
        
        self.view.addSubview(self.paramInterval)
    }
    
    /**
     * 스위치 버튼 생성
     */
    func createSwitchButton(){
        self.paramUpdate = UISwitch()
        self.paramUpdate.frame = CGRect(x: 120, y: 150, width: 50, height: 30)
        self.paramUpdate.setOn(true, animated: true)
        self.view.addSubview(self.paramUpdate)
    }
    
    /**
     * 텍스트 필드 생성
     */
    func createTextField(){
        
        // 이메일 입력 필드
        self.paramEmail = UITextField()
        self.paramEmail.frame = CGRect(x: 120, y: 100, width: 220, height: 30)
        self.paramEmail.font = UIFont.systemFont(ofSize: 13)
        self.paramEmail.borderStyle = UITextField.BorderStyle.roundedRect
        
        self.view.addSubview(self.paramEmail)
    }
    
    
    /**
     * 라벨 생성
     */
    func createLabel(){
        // 임일 레이블 생성 및 기본 문구 설정
        let lblEmail = UILabel()
        lblEmail.frame = CGRect(x: 30, y: 100, width: 100, height: 30)
        lblEmail.text = "이메일"
        // 레이블 폰트 설정
                lblEmail.font = UIFont.systemFont(ofSize: 14)
        //        lblEmail.font = UIFont.boldSystemFont(ofSize: 14)
        //        lblEmail.font = UIFont(name: "ChalkboardSE-Bold", size: 14)
        
        // 레이블 뷰 추가
        self.view.addSubview(lblEmail)
        
        
        // 라벨 생성
        let lblUpdate = UILabel()
        lblUpdate.frame = CGRect(x: 30, y: 150, width: 100, height: 30)
        lblUpdate.text = "자동갱신"
        lblUpdate.font = UIFont.systemFont(ofSize: 14)
        
        self.view.addSubview(lblUpdate)
        
        
        // 라벨 생성
        let lblInterval = UILabel()
        lblInterval.frame = CGRect(x: 30, y: 200, width: 100, height: 30)
        lblInterval.text = "갱신주기"
        lblInterval.font = UIFont.systemFont(ofSize: 14)
        
        self.view.addSubview(lblInterval)
        
    }
}
