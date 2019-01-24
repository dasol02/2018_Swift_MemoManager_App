import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // 코드로 버튼 생성
        let csBtn = CSButton()
        csBtn.frame = CGRect(x: 0, y: 0, width: 150, height: 30)
        csBtn.center = CGPoint(x: self.view.frame.width/2, y: self.view.frame.height/2)
        self.view.addSubview(csBtn)

    }


}

