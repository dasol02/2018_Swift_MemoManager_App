import UIKit

class ViewController: UIViewController {

    // 버튼 액션 연결 스토리보드
    @IBAction func actionBasicButtonTouch(_ sender: Any) {
        NSLog("Button Action", "actionBasicButtonTouch")
        if let btn = sender as? UIButton {
            btn.setTitle("클릭되었습니다. (Story Board)", for: UIControl.State.normal)
        }
    }
    
    // 버튼 액션 연결 Code
    @objc func actionCustomButtonTouch(_ sender: Any){
        NSLog("Button Action", "actionCustomButtonTouch")
        if let btn = sender as? UIButton {
            btn.setTitle("클릭되었습니다. (CODE)", for: UIControl.State.normal)
        }
    }
    
    // 버튼 액션 연결 Code -> Type = UIButton
    @objc func actionCustomButtonTouch(sender: UIButton){
        NSLog("Button Action", "actionCustomButtonTouch")
        sender.setTitle("클릭되었습니다. (CODE Type = UIButton)", for: UIControl.State.normal)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        // 버튼 생성
        let btnCustom = UIButton(type:UIButton.ButtonType.system)
        btnCustom.frame = CGRect(x: 150, y: 100, width: self.view.frame.size.width-100, height: 30)
        btnCustom.setTitle("텍스트 버튼", for:UIControl.State.normal)
        btnCustom.center = CGPoint(x: self.view.frame.size.width/2 , y: 300)
        
        // 버튼 액션 이벤트 연결
        btnCustom.addTarget(self, action: #selector(actionCustomButtonTouch(_:)), for: UIControl.Event.touchUpInside)
        
        // 버튼 화면 추가
        self.view.addSubview(btnCustom)
    }


}

