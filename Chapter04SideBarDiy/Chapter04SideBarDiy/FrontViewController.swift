import UIKit

class FrontViewController: UIViewController {
    
    // 딜리게이트 선언
    var delegate: RevealViewController?

    override func viewDidLoad() {
        super.viewDidLoad()

        let btnSideBar = UIBarButtonItem(image: UIImage(named: "sidemenu.png"), style: UIBarButtonItem.Style.plain, target: self, action: #selector(moveSide(_:)))
        
        self.navigationItem.leftBarButtonItem = btnSideBar
        
    }
    
    
    // 사용자 액션에 따라 딜리게이트 메소드 추가
    @objc func moveSide(_ sender: Any){
     
        if self.delegate?.isSideBarShowing == false {
            self.delegate?.openSideBar(nil)
            
        }else{
            self.delegate?.closeSideBar(nil)
        }
    }

}
