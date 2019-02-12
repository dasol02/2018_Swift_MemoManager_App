import UIKit

class ProfileViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let uinfo = UserInfoManager() // 개인 정보 관리 매니저
    
    let profileImage = UIImageView()
    let tv = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isHidden = true
        
        // 뒤로 가기 버튼 처리
        let backBtn = UIBarButtonItem(title: "닫기", style: .plain, target: self, action: #selector( close(_:) ))
	 	self.navigationItem.leftBarButtonItem = backBtn
        
        
        // 프로필 사진에 들어갈 기본 이미지
//        let image = UIImage(named: "account.jpg")
        let image = self.uinfo.profile
        
        // 프로필 이미지 처리
        self.profileImage.image = image
        self.profileImage.frame.size = CGSize(width: 100, height: 100)
        self.profileImage.center = CGPoint(x: self.view.frame.width/2, y: 270)
        
        // 프로필 이미지 둥글게 만들기
        self.profileImage.layer.cornerRadius = self.profileImage.frame.width/2
        self.profileImage.layer.borderWidth = 0
        self.profileImage.layer.masksToBounds = true
        
        // 프로필 뷰 추가
        self.view.addSubview(self.profileImage)
        
        // 배경 이미지 설정
        let bg = UIImage(named: "profile-bg")
        let bgImg = UIImageView(image: bg)
        bgImg.frame.size = CGSize(width: bgImg.frame.size.width, height: bgImg.frame.size.height)
        bgImg.center = CGPoint(x: self.view.frame.width/2, y: 40)
        
        bgImg.layer.cornerRadius = bgImg.frame.size.width/2
        bgImg.layer.borderWidth = 0
        bgImg.layer.masksToBounds = true
        self.view.addSubview(bgImg)
        
        //** 배경 이미지 최상단 작성 아닐 경우 아래 구문 추가
        self.view.bringSubviewToFront(self.tv)
        self.view.bringSubviewToFront(self.profileImage)
        
        
        // 테이블 뷰 생성
        self.tv.frame = CGRect(x: 0, y: self.profileImage.frame.origin.y + self.profileImage.frame.size.height + 20, width: self.view.frame.width, height: 100)
        self.tv.dataSource = self
        self.tv.delegate = self
        
        self.view.addSubview(self.tv)
        
        // 로그인 or 로그아웃 버튼 생성
        self.drawBtn()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(profile(_:)))
        self.profileImage.addGestureRecognizer(tap)
        self.profileImage.isUserInteractionEnabled = true

    }
    
    // 로그인 얼럿창 생성
    @objc func doLogin(_ sender: Any){
        let loginAlert = UIAlertController(title: "Login", message: nil, preferredStyle: UIAlertController.Style.alert)
        
        // 알림창에 들어갈 입력폼 추가
        loginAlert.addTextField { (textField) in
            textField.placeholder = "Your Account"
        }
        loginAlert.addTextField { (textField) in
            textField.placeholder = "Password"
            textField.isSecureTextEntry = true
        }
        
        loginAlert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
        loginAlert.addAction(UIAlertAction(title: "Login", style: UIAlertAction.Style.destructive, handler: { (loginalert) in
            
            let account = loginAlert.textFields?[0].text ?? ""
            let passwd = loginAlert.textFields?[1].text ?? ""
            
            if self.uinfo.login(inputAccount: account, passwd: passwd){
                // 로그인 성공
                self.tv.reloadData()
                self.profileImage.image = self.uinfo.profile
                self.drawBtn()
            }else{
                let msg = "로그인에 실패하였습니다."
                let alert = UIAlertController(title: nil, message: msg, preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil))
                self.present(alert, animated: false, completion: nil)
            }
            
        }))
        
        self.present(loginAlert, animated: false, completion: nil)
        
    }
    
    // 로그아웃
    @objc func doLogout(_ sender: Any){
        let msg = "로그아웃하시겠습니까?"
        let alert = UIAlertController(title: nil, message: msg, preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "취소", style: UIAlertAction.Style.cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "확인", style: UIAlertAction.Style.destructive, handler: { (alert) in
            if self.uinfo.logout() {
                // 로그아웃 성공
                self.tv.reloadData()
                self.profileImage.image = self.uinfo.profile
                self.drawBtn()
            }
        }))
        
        self.present(alert, animated: false, completion: nil)
    }
    
    
    
    // 현재 화면 종료
    @objc func close(_ sender: Any){
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    // 로그인 or 로그아웃 버튼 추가
    func drawBtn(){
        // 배경 뷰 생성
        let v = UIView()
        v.frame.size.width = self.view.frame.width
        v.frame.size.height = 40
        v.frame.origin.x = 0
        v.frame.origin.y = self.tv.frame.origin.y + self.tv.frame.height
        v.backgroundColor = UIColor(red: 0.98, green: 0.98, blue: 0.98, alpha: 1.0)
        
        self.view.addSubview(v)
        
        // 버튼 생성
        let btn = UIButton(type: UIButton.ButtonType.system)
        btn.frame.size.width = 100
        btn.frame.size.height = 30
        btn.center.x = v.frame.size.width / 2
        btn.center.y = v.frame.size.height / 2
        
        
        // 로그인 유무에 따라 버튼 텍스트 및 이벤트 처리
        if self.uinfo.isLogin == true {
            btn.setTitle("로그아웃", for: UIControl.State.normal)
            btn.addTarget(self, action: #selector(doLogout(_:)), for: UIControl.Event.touchUpInside)
        }else{
            btn.setTitle("로그인", for: UIControl.State.normal)
            btn.addTarget(self, action: #selector(doLogin(_:)), for: UIControl.Event.touchUpInside)
        }
        v.addSubview(btn)
        
    }
    
    // MARK: TableView Data Source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.value1, reuseIdentifier: "cell")
        cell.textLabel?.font = UIFont.systemFont(ofSize: 14)
        cell.detailTextLabel?.font = UIFont.systemFont(ofSize: 13)
        cell.accessoryType = .disclosureIndicator
        
        switch indexPath.row {
        case 0:
            cell.textLabel?.text = "이름"
//            cell.detailTextLabel?.text = "꼼꼼한재은 씨"
            cell.detailTextLabel?.text = self.uinfo.name ?? "Login Please"
            break
        case 1:
            cell.textLabel?.text = "계정"
//            cell.detailTextLabel?.text = "123@gamil.com"
            cell.detailTextLabel?.text = self.uinfo.name ?? "Login Plase"
            break
        default:
            ()
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if self.uinfo.isLogin == false {
            self.doLogin(self.tv)
        }
    }
    
    // MARK: UIImage Picker
    func imgPicker( _ source: UIImagePickerController.SourceType){
        let picker = UIImagePickerController()
        picker.sourceType = source
        picker.delegate = self
        picker.allowsEditing = true
        self.present(picker, animated: true, completion: nil)
    }
    
    // 프로필 사진 선택 메서드
    @objc func profile(_ sender: UIButton){
        
        // 미로그인시 로그인창 제공
        guard self.uinfo.account != nil else {
            self.doLogin(self)
            return
        }
        
        let alert = UIAlertController(title: nil, message: "사진을 가져올 곳을 선택해 주세요", preferredStyle: UIAlertController.Style.actionSheet)
        
        // 카메라
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera){
            alert.addAction(UIAlertAction(title: "카메라", style: UIAlertAction.Style.default, handler: { (UIAlertAction) in
                self.imgPicker(UIImagePickerController.SourceType.camera)
            }))
        }
        
        // 저장 앨범
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.savedPhotosAlbum){
            alert.addAction(UIAlertAction(title: "저장된 앨범", style: UIAlertAction.Style.default, handler: { (UIAlertAction) in
                self.imgPicker(UIImagePickerController.SourceType.savedPhotosAlbum)
            }))
        }
        
        // 포토 라이브러리
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary){
            alert.addAction(UIAlertAction(title: "포토 라이브러리", style: UIAlertAction.Style.default, handler: { (UIAlertAction) in
                self.imgPicker(UIImagePickerController.SourceType.photoLibrary)
            }))
        }
        
        //취소 버튼
        alert.addAction(UIAlertAction(title: "취소", style: UIAlertAction.Style.cancel, handler: nil))
        
        
        self.present(alert, animated: false, completion: nil)
    }
    
    // 이미지 선택시 호출
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let img = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            self.uinfo.profile = img
            self.profileImage.image = img
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
}
