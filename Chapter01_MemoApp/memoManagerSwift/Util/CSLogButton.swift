import UIKit


public enum CSLogType: Int {
    case basic  // 기본 로그 타입
    case title  // 버튼의 타이틀을 출력
    case tag    // 버튼의 태그값을 출력
}

@IBDesignable
public class CSLogButton: UIButton {

    // 로그 출력 타입
    public var logType: CSLogType = .basic
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.setBackgroundImage(UIImage(named: "button-bg"), for: UIControl.State.normal)
        self.tintColor = UIColor.white
        
        // 이벤트 연결
        self.addTarget(self, action: #selector(logging(_:)), for: UIControl.Event.touchUpInside)
    }
    
    // 로그 출력 메서드
    @objc func logging(_ sender: UIButton){
        switch self.logType {
        case .basic:
            NSLog("버튼이 클릭되었습니다.")
            break
        case .title:
            let btnTitle = sender.titleLabel?.text ?? "타이틀이 없는"
            
            /* 위와 같은 구문
             let btnTitle = sender.titleLabel?.text
             if btnTitle = nil {
             btnTitle = "타이틀 없는"
             }
            */
            NSLog("\(btnTitle) 버튼이 클릭되었습니다.")
            break
        case .tag:
            NSLog("\(sender.tag) 버튼이 클릭되었습니다.")
            break
        }
    }

}
