import UIKit

class FirstViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
//        super.setMainContentTitlelabel(titleString: BaseViewController.FristViewController)
//        앱 딜리게이트에서 설정 -> 초기 클릭 이전에 이미지 설정이 안됨
    }
    
    // 화면 터치하여 택바 생김 없음 설정
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let tabBar = self.tabBarController?.tabBar
//        tabBar?.isHidden = (tabBar?.isHidden == true ) ? false : true
        
        // 애니메이션 효과
        UIView.animate(withDuration: TimeInterval(0.15)) {
            tabBar?.alpha = (tabBar?.alpha == 0 ? 1 : 0)
        }
        
// 클로저 함수 
//        {
//            (value1:Int, value2 : Int) -> Int in
//            let resilt = value1 + value2
//            return resilt
//        }
        
    }
}
