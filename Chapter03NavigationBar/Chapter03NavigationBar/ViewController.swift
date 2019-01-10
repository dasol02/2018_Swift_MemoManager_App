import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNavigationItem() // 네비게이션 아이템 생성
    }
    
//** 네비게이션 아이템 생성
    func setNavigationItem(){
        self.inintLeftBarButton() // 네비게이션 왼쪽 버튼 추가
        self.inintRightBarButton() // 네비게이션 오른쪽 버튼 추가
        self.initTitleInput()   // 타이틀에 텍스트 필드 추가
        //        self.initTitleImage() // 타이틀 이미지 추가
        //        self.initTitleNew() // 타이틀 추가 (타이틀 뷰 추가)
        //        self.initTitle()    // 타이틀 추가 (라벨 추가)
    }
    
//** 네비게이션 좌측 버튼 추가
    func inintRightBarButton(){
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: 70, height: 37)
        
        
        // 카운트 라벨
        let cnt = UILabel()
        cnt.frame = CGRect(x: 10, y: 8, width: 20, height: 20)
        cnt.font = UIFont.boldSystemFont(ofSize: 10)
        cnt.textColor = UIColor(red: 0.60, green: 0.60, blue: 0.60, alpha: 1.0)
        cnt.text = "12"
        cnt.textAlignment = .center
        cnt.layer.cornerRadius = 3 // 모서리 둥금 처리
        cnt.layer.borderWidth = 2
        cnt.layer.borderColor = UIColor(red: 0.60, green: 0.60, blue: 0.60, alpha: 1.0).cgColor
        
        view.addSubview(cnt)
        
        
        // 더보기 버튼
        let more = UIButton(type: .system)
        more.frame = CGRect(x: 50, y: 10, width: 16, height: 16)
        more.setImage(UIImage(named: "more"), for: .normal)
        view.addSubview(more)
        
        // 아이템 추가
        let rightItem = UIBarButtonItem(customView: view)
        self.navigationItem.rightBarButtonItem = rightItem
    }
    
//** 네비게이션 우측 버튼 추가
    func inintLeftBarButton(){
        let backImage = UIImage(named: "arrow-back")
        let leftItem = UIBarButtonItem(image: backImage, style: .plain, target: self, action: nil)
        self.navigationItem.leftBarButtonItem = leftItem
        
        
//        let leftItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(fina))
//        self.navigationItem.leftBarButtonItem = leftItem
        
//        let view = UIView()
//        view.frame = CGRect(x: 0, y: 0, width: 150, height: 37)
//        let leftItem = UIBarButtonItem(customView: view)
//        self.navigationItem.leftBarButtonItem = leftItem
    }

//** 네비게이션 상단 텍스트 뷰 생성
    func initTitleInput(){
      let navigationTitleTextField = UITextField()
        navigationTitleTextField.frame = CGRect(x: 0, y: 0, width: 300, height: 35)
        navigationTitleTextField.backgroundColor = UIColor.white
        navigationTitleTextField.font = UIFont.systemFont(ofSize: 13)
        navigationTitleTextField.autocapitalizationType = .none
        navigationTitleTextField.autocorrectionType = .no
        navigationTitleTextField.spellCheckingType = .no
        navigationTitleTextField.keyboardType = .URL
        navigationTitleTextField.keyboardAppearance = .dark
        navigationTitleTextField.layer.borderWidth = 0.3
        navigationTitleTextField.layer.borderColor = UIColor(red: 0.60, green: 0.60, blue: 0.60, alpha: 1.0).cgColor
        
        self.navigationItem.titleView = navigationTitleTextField
        
    }
    
//** 네비게이션 상단 타이틀 뷰 이미지 생성
    func initTitleImage(){
        let image = UIImage(named: "swift_logo")
        let imageView = UIImageView(image: image)
        
        self.navigationItem.titleView = imageView
    }
    
//** 네비게이션 상단 타이틀 뷰 화면 생성
    func initTitleNew(){
        // 네비게이션 컨텐츠 뷰 정의
        let containerView = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 36))
        
        // 상단 타이틀 바 정의
        let topTitle = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 18))
        topTitle.numberOfLines = 1
        topTitle.textAlignment = .center
        topTitle.font = UIFont.systemFont(ofSize: 15)
        topTitle.textColor = UIColor.white
        topTitle.text = "58개 숙소"

        // 하단 타이틀 바 정의
        let subTitle = UILabel(frame: CGRect(x: 0, y: 18, width: 200, height: 18))
        subTitle.numberOfLines = 1
        subTitle.textAlignment = .center
        subTitle.font = UIFont.systemFont(ofSize: 12)
        subTitle.textColor = UIColor.white
        subTitle.text = "1박(1월 10일 ~ 1월 11일)"
        
        // 컨텐츠 뷰에 타이틀바 추가
        containerView.addSubview(topTitle)
        containerView.addSubview(subTitle)
        
        // 네비게이션에 컨텐츠 뷰 추가
        self.navigationItem.titleView = containerView
        
        // 네비게이션 배경 색상 설정
        let color = UIColor(red: 0.02, green: 0.22, blue: 0.49, alpha: 1.0)
        self.navigationController?.navigationBar.barTintColor = color
    }
    
    
//** 네비게이션 상단 타이틀 뷰 화면 생성
    func initTitle(){
        
        // 타이틀용 레이블 객체 선언
        let nTitle = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 40))
        
        // 타이틀 영역 속성 설정
        nTitle.numberOfLines = 2
        nTitle.textAlignment = .center
        nTitle.textColor = UIColor.white
        nTitle.font = UIFont.systemFont(ofSize: 15)
        nTitle.text = "58개 숙소 \n 1박(1월 10일 ~ 1월 11일)"
        
        // 네비게이션 타이틀에 입력
        self.navigationItem.titleView = nTitle
        
        // 네비게이션 배경 색상 설정
        let color = UIColor(red: 0.02, green: 0.22, blue: 0.49, alpha: 1.0)
        self.navigationController?.navigationBar.barTintColor = color
        
    }
    
}
