import UIKit

class FrontViewController: UIViewController {
    
    // 딜리게이트 선언
    var delegate: RevealViewController?

    override func viewDidLoad() {
        super.viewDidLoad()

        let btnSideBar = UIBarButtonItem(image: UIImage(named: "sidemenu.png"), style: UIBarButtonItem.Style.plain, target: self, action: #selector(moveSide(_:)))
        
        self.navigationItem.leftBarButtonItem = btnSideBar
        
        
        // 화면 제스처 이벤트 추가 (왼쪽)
        let dragLeft = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(moveSide(_:)))
        dragLeft.edges = UIRectEdge.left
        self.view.addGestureRecognizer(dragLeft)
        
        // 화면 제스처 이벤트 추가 (오른쪽)
        let dragRight = UISwipeGestureRecognizer(target: self, action: #selector(moveSide(_:)))
        dragRight.direction = .left
        self.view.addGestureRecognizer(dragRight)
        
    }
    
    
    // 사용자 액션에 따라 딜리게이트 메소드 추가
    @objc func moveSide(_ sender: Any){
        
        if sender is UIScreenEdgePanGestureRecognizer {
            // 왼쪽에서 우측으로 화면 이벤트
            self.delegate?.openSideBar(nil)
        }else if sender is UISwipeGestureRecognizer {
            // 중앙에서 좌측으로 화면 이벤트
            self.delegate?.closeSideBar(nil)
        }else if sender is UIBarButtonItem {
            if self.delegate?.isSideBarShowing == false {
                self.delegate?.openSideBar(nil)
            }else{
                self.delegate?.closeSideBar(nil)
            }
        }
    }

}
