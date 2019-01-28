import UIKit

class FrontViewController: UIViewController {

    @IBOutlet weak var sideBarButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setSideBarButton()
    
    }
    
    
    // Side Bar Button 기능 설정
    private func setSideBarButton(){
        // 메인(ReavealViewController 정보 참조)
        if let revealVC = self.revealViewController() {
            
            // 버튼이 클릭될 떄 메인 컴트롤러에 정의된 revealToggle 메서드 호출
            self.sideBarButton.target = revealVC
            self.sideBarButton.action = #selector(revealVC.revealToggle(_:))
            
            // 제스처 인식 지정
            self.view.addGestureRecognizer(revealVC.panGestureRecognizer())
        }
    }
    
}
