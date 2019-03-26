import UIKit
import Alamofire

class JoinViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    @IBOutlet weak var profile: UIImageView!
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    
    var fieldAccount: UITextField! // 계정 필드
    var fieldPassword: UITextField! // 비밀번호 필드
    var fieldName: UITextField! // 이름 필드
    
    var isCalling = false // API 호출 상태값을 관리할 변수
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUIDelegate()
        
        self.profile.layer.cornerRadius = self.profile.frame.width / 2
        self.profile.layer.masksToBounds = true
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(tapperProfile(_:)))
        self.profile.addGestureRecognizer(gesture)
        
        self.view.bringSubviewToFront(indicatorView)
    }
    
    
    // MARK: - Public
    func setUIDelegate(){
        self.tableview.dataSource = self
        self.tableview.delegate = self
    }
    
    
    func setTextFieldStyle(target: UITextField, placeholder: String, boardStyle: UITextField.BorderStyle, fontSize: CGFloat){

        target.placeholder = placeholder
        target.borderStyle = .none
        target.font = UIFont.systemFont(ofSize: 14)
        
    }

    
    // MARK: - Action
    @IBAction func submit(_ sender: Any) {
        
        if self.isCalling == true {
            self.alert("진행 중입니다. 잠시만 기다려주세요.")
            return
        }else{
            self.isCalling = true
        }
        
        self.indicatorView.startAnimating()
        
        // 1. 전달할 값 준비
        // 1-1. 이미지를 Base64 인코딩 처리
        let profile = self.profile.image!.pngData()?.base64EncodedString()
        
        
        // 1-2. 전달값을 Parameters 타입의 객체로 정의
        let param: Parameters = [
            "account" : self.fieldAccount.text!,
            "passwd" : self.fieldPassword.text!,
            "name" : self.fieldName.text!,
            "profile_image" : profile!
        ]
        
         // 2. API 호출
        let url = "http://swiftapi.rubypaper.co.kr:2029/userAccount/join"
        let call = Alamofire.request(url, method: .post, parameters: param, encoding: JSONEncoding.default)
        
        // 3. 서버 응답값 처리
        call.responseJSON { res in
            
            self.indicatorView.stopAnimating()
            
            // 3-1. JSON 형식으로 값이 제대로 전달되었는지 확인
            guard let jsonObject = res.result.value as? [String: Any] else {
                self.isCalling = false
                self.alert("서버 호출 과정에서 오류가 발생했습니다.")
                return
            }
            
            // 3-2. 응답 코드 확인. 0이면 성공
            let resultCode = jsonObject["result_code"] as! Int
            if resultCode == 0 {
                self.alert("가입이 완료되었습니다.") {
                    self.performSegue(withIdentifier: "backProfileVC", sender: self)
                }
            } else { // 3-4. 응답 코드가 0이 아닐 때에는 실패
                let errorMsg = jsonObject["error_msg"] as! String
                self.alert("오류발생 : \(errorMsg)")
                self.isCalling = false
            }
        }
        
        
    }
    
    
    @objc func tapperProfile(_ sender: Any) {
        
        // 전반부) 원하는 소스 타입을 선택 할 수 있는 액션시트 구현
        let msg = "프로필 이미지를 읽어올 곳을 선택하세요."
        let sheet = UIAlertController(title: msg, message: nil, preferredStyle: UIAlertController.Style.actionSheet)
        
        sheet.addAction(UIAlertAction(title: "취소", style: UIAlertAction.Style.cancel, handler: nil))
        sheet.addAction(UIAlertAction(title: "저장된 앨범", style: UIAlertAction.Style.default) { (_) in
            selectLibrary(src: UIImagePickerController.SourceType.savedPhotosAlbum)
        })
        sheet.addAction(UIAlertAction(title: "포토 라이브러리", style: UIAlertAction.Style.default) { (_) in
            selectLibrary(src: UIImagePickerController.SourceType.photoLibrary)
        })
        sheet.addAction(UIAlertAction(title: "카메라", style: UIAlertAction.Style.default) { (_) in
            selectLibrary(src: UIImagePickerController.SourceType.camera)
        })
        
        self.present(sheet, animated: false, completion: nil)
        
        // 후반부 전달된 소스타입에 맞게 이미지 피커 창을 여는 내부 함수
        func selectLibrary(src:UIImagePickerController.SourceType) {
            if UIImagePickerController.isSourceTypeAvailable(src){
                let picker = UIImagePickerController()
                picker.delegate = self
                picker.allowsEditing = true
                self.present(picker, animated: false, completion: nil)
            }else{
                self.alert("사용할 수 없는 타입입니다.")
            }
        }
        
    }
    
    
    // MARK: - TableView DataSoruce
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableview.dequeueReusableCell(withIdentifier: "cell")!
        
        let tfFrame = CGRect(x: 20, y: 0, width: cell.bounds.width - 20, height: 37)
        
        switch indexPath.row {
        case 0:
            self.fieldAccount = UITextField(frame: tfFrame)
            self.setTextFieldStyle(target: self.fieldAccount, placeholder: "계정(이메일)", boardStyle: UITextField.BorderStyle.none, fontSize: 14)
            self.fieldAccount.autocapitalizationType = .none
            cell.addSubview(self.fieldAccount)
        case 1:
            self.fieldPassword = UITextField(frame: tfFrame)
            self.setTextFieldStyle(target: self.fieldPassword, placeholder: "비밀번호", boardStyle: UITextField.BorderStyle.none, fontSize: 14)
            self.fieldPassword.isSecureTextEntry = true
            cell.addSubview(self.fieldPassword)
        case 2:
            self.fieldName = UITextField(frame: tfFrame)
            self.setTextFieldStyle(target: self.fieldName, placeholder: "이름", boardStyle: UITextField.BorderStyle.none, fontSize: 14)
            cell.addSubview(self.self.fieldName)
        default:
            ()
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    
    // MARK: - ImagePicker Delegate
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let img = info[.originalImage] as? UIImage {
            self.profile.image = img
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    
}
