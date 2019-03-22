import UIKit

class MemoFormViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextViewDelegate {

    @IBOutlet weak var contents: UITextView!
    @IBOutlet weak var preview: UIImageView!
    
    lazy var dao = MemoDAO()
    
    var subject : String!           // 네비게이션 상단의 제목 타이틀
    var picker = UIImagePickerController() // 이미지 피커 인스턴스를 생성한다.
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.contents.delegate = self
        picker.delegate = self
        
        let bgImage = UIImage(named: "memo-background")!
        self.view.backgroundColor = UIColor(patternImage: bgImage)
        
        self.contents.layer.borderWidth = 0
        self.contents.layer.borderColor = UIColor.clear.cgColor
        self.contents.backgroundColor = UIColor.clear
        
        // 줄간격 추가
        let style = NSMutableParagraphStyle()
        style.lineSpacing = 9
        self.contents.attributedText = NSAttributedString(string: " ", attributes: [NSAttributedString.Key.paragraphStyle : style])
        self.contents.text = ""
    }
    
    // MARK: - Action
    // 저장 버튼을 클릭했을 때 호출되는 메소드
    @IBAction func save(_ sender: Any) {
        
        // 텍스트 필드의 내용이 비어있을경우 얼럿창 제공
        guard self.contents.text?.isEmpty == false else {
            
            // 얼럿창 UI 설정
            let alertView = UIViewController()
            let iconImgae = UIImage(named: "warning-icon-60")
            alertView.view = UIImageView(image: iconImgae)
            alertView.preferredContentSize = iconImgae?.size ?? CGSize.zero
            
            let alert = UIAlertController(title: nil, message: "내용을 입력해주세요", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            alert.setValue(alertView, forKey: "contentViewController")
            self.present(alert, animated: true)
            
            return
        }
        
        // MemoData 객체를 생성하고, 데이터를 담는다.
        let data = MemoData()
        data.title    = self.subject            // 제목
        data.contents = self.contents.text      // 내용
        data.image    = self.preview.image      // 이미지
        data.regdate  = Date()                  // 작성 시간
        
//        // 앱 딜리게이트 객체를 읽어온 다음, memolist 배열에 MemoData 객체를 추가한다.
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//        appDelegate.memolist.append(data)
        
        // 코어 데이타 추가
        self.dao.insert(data)
        
        
        // 작성폼 화면을 종료하고, 이전화면으로 되돌아 간다.
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    
    // 카메라 버튼을 클릭했을 때 호출되는 메소드
    @IBAction func pick(_ sender: Any) {
        
        // 얼럿 뷰 생성
        let alertView = UIAlertController(title: "사진을 추가할 방법을 선택하여 주십시오.", message: "메시지 내용", preferredStyle: .actionSheet)
        
        // 얼럿 뷰 내의 노출될 아이템 추가
        alertView.addAction(UIAlertAction(title: "카메라", style: .default, handler: { (_) in
            
            // 해당 아이템 클릭시 호출될 메소드
            self.presentPick(source: .camera)
        }))
        
        alertView.addAction(UIAlertAction(title: "저장앨범", style: .default, handler: { (_) in
            self.presentPick(source: .savedPhotosAlbum)
        }))

        alertView.addAction(UIAlertAction(title: "사진 라이브러리", style: .default, handler: { (_) in
            self.presentPick(source: .photoLibrary)
        }))
        
        alertView.addAction(UIAlertAction(title: "취소", style: .cancel, handler: { (_) in
            
        }))
        
        // 얼럿뷰 선택화면 화면 호출
        self.present(alertView, animated:false)
    }
    
    
    // 이미지 선택 관련 화면을 생성할 메소드(이미지 로드방법을 선택하면 호출되는 메소드)
    func presentPick(source:UIImagePickerController.SourceType){
        
        // 이미지를 추가할 방법 가능 여부 파악
        guard UIImagePickerController.isSourceTypeAvailable(source) == true else {
            let alert = UIAlertController(title: "사용할 수 없는 타입입니다.", message: nil, preferredStyle: .alert)
            self.present(alert, animated: false)
            return
        }
 
        // 이미지 피커 인스턴스 생성
        let picker = UIImagePickerController()
        
        // 이미지 피커 관련 호출 타입 및 딜리게이트 연결
        picker.delegate = self
        picker.allowsEditing = true
        picker.sourceType = source
        
        // 이미지 피커 화면 표시
        self.present(picker, animated: false)
    }
    
    
    
    // 이미지 선택을 완료했을 떄 호출되는 메소드
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        // 선택된 이미지를 미리보기에 표시한다.
        self.preview.image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
        
        // 이미지 피커 컨트롤러를 닫는다.
        picker.dismiss(animated: false)
    }
    
    
    // 텍스트 필드의 텍스트가 변경될때 호출되는 메소드
    func textViewDidChange(_ textView: UITextView) {
        
        // 내용의 최대 15자리까지 읽어 subject 변수에 저장한다.
        let contents = textView.text as NSString
        let length = ((contents.length > 15) ? 15 : contents.length)
        self.subject = contents.substring(with: NSRange(location: 0, length: length))
        
        // 내비게이션 타이틀에 표시한다.
        self.navigationItem.title = subject
    }
    
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let bar = self.navigationController?.navigationBar
        
        let ts = TimeInterval(0.3)
        UIView.animate(withDuration : ts) {
            bar?.alpha = (bar?.alpha == 0 ? 1 : 0)
        }
    }
}
