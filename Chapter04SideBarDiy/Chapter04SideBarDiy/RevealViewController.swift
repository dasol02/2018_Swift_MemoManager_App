import UIKit

// 메인화면과 사이드 화면을 컨트롤할 뷰컨트롤
class RevealViewController: UIViewController {
    
    // 변수 설정
    var contentVC: UIViewController?    // 메인화면 뷰컨트롤
    var sideVC: UIViewController?       // 사이드 바 뷰컨트롤
    var isSideBarShowing = false        // 사이드바 노출 여부
    
    // 상수 설정
    let SLIDE_TIME = 0.3                // 사이드바 움직이는 속도
    let SIDEBAR_WIDTH: CGFloat = 260    // 사이드바 노출 범위

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
    }
    
    // 초기화면 설정
    // Stroyboard의 FrontViewController을 RevealViewController자식으로 등록한다.
    // 이때 FrontViewController가 가지고 있는 NavigationController을 RevealViewController로 변경한다.
    // 즉 NavigationController의 루트 뷰는 RevealViewController이며, RevealViewController의 자식뷰로 FrontViewController등록한다.
    func setupView(){
        // 메인 컨텐츠 객체 참조
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "sw_front") as? UINavigationController {
            self.contentVC = vc             // 클래스 전체에서 참조 가능하게 선언
            self.addChild(vc)               // 프론트 뷰컨을 메인 뷰컨 자식으로 등록
            
            // 딜리게이트 연결
            let frontVC = vc.viewControllers[0] as? FrontViewController
            frontVC?.delegate = self
            
            self.view.addSubview(vc.view)   // 서브 뷰 추가
            vc.didMove(toParent: self)      // vc의 부모 뷰가 바뀌었음을 알려준다.

        }
    }
    
    // 사이드바 읽기
    func getSideView(){
        
        if self.sideVC == nil {
            if let vc = self.storyboard?.instantiateViewController(withIdentifier: "sw_rear"){
                self.sideVC = vc    // 객체 참조 가능하게 변수 지정
                self.addChild(vc)   // 자식뷰로 추가
                self.view.addSubview(vc.view)   // 화면의 서브뷰 추가
                vc.didMove(toParent: self)      // 부모뷰가 바뀜을 알려준다.
                self.view.bringSubviewToFront((self.contentVC?.view)!) // 이전 화면들을 최상위로 올린다.
            }
        }
        
    }
    
    // 콘텐츄 뷰에 그림자 효과
    func setShadowEffect(shadow: Bool, offset: CGFloat){
        
        // 그림자 효과
        if(shadow == true){
            self.contentVC?.view.layer.cornerRadius = 10 // 모서리 둥글기
            self.contentVC?.view.layer.shadowOpacity = 0.8  // 튜명도
            self.contentVC?.view.layer.shadowColor = UIColor.black.cgColor // 색상
            self.contentVC?.view.layer.shadowOffset = CGSize(width: offset, height: offset) // 크기
        }else{
            self.contentVC?.view.layer.cornerRadius = 0.0;
            self.contentVC?.view.layer.shadowOffset = CGSize(width: 0, height: 0)
        }
        
    }
    
    // 사이드 바 열기
    func openSideBar(_ comple: ( () -> Void)? ){
        
        self.getSideView()  // 정의 메소드 호출
        self.setShadowEffect(shadow: true, offset: -2) // 그림자 효과 설정
        // 애니메이션 옵션 설정
        let options = UIView.AnimationOptions([.curveEaseInOut, .beginFromCurrentState])
        
        // 애니메이션 실행
        UIView.animate(withDuration: TimeInterval(self.SLIDE_TIME), delay: TimeInterval(0), options: options, animations: {
            self.contentVC?.view.frame = CGRect(x: self.SIDEBAR_WIDTH, y: 0, width: self.view.frame.width, height: self.view.frame.height)
            
        }, completion: {
            // 첫번쨰 변수($0)의 값이 true라면 하기 내용 실행 이후 comple?()메서드 실행
            if $0 == true {
                self.isSideBarShowing = true // 열림상태로 플래그 변경
                comple?()   // 완료함수 실행
            }
        })
    }
    
    //  사이드 바 닫기
    func closeSideBar(_ comple: ( () -> Void)? ){
        
        // 애니메이션 옵션 설정
        let options = UIView.AnimationOptions([.curveEaseInOut, .beginFromCurrentState])
        
        // 애니메이션 실행
        UIView.animate(withDuration: TimeInterval(self.SLIDE_TIME), delay: TimeInterval(0), options: options, animations: {
            self.contentVC?.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
            
        }, completion: {
            if $0 == true {
                self.sideVC?.view.removeFromSuperview() // 뷰 제거
                self.sideVC = nil                       // 뷰 메모리 제거
                self.isSideBarShowing = false           // 상태 변경
                self.setShadowEffect(shadow: false, offset: 0) // 그림자 효과 제거
                comple?()   // 완료함수 실행
            }
        })
    }
}
