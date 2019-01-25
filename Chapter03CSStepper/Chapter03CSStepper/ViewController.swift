import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var storyBoardBtn: CSStepper!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // 코드로 버튼 생성
        let stepper = CSStepper()
        stepper.frame = CGRect(x: 30, y: 100, width: 130, height: 30)
        stepper.addTarget(self, action: #selector(logging(_:)), for: UIControl.Event.valueChanged)
        stepper.tag = 0
        
        // 스토리 보드 생성 버튼 이벤트 연결
        self.storyBoardBtn.addTarget(self, action: #selector(logging(_:)), for: UIControl.Event.valueChanged)
        self.storyBoardBtn.tag = 1
        
        
        self.view.addSubview(stepper)
    }

    // 스테퍼 메서드 (값 변경시)
    @objc func logging(_ sender: CSStepper){
        if sender.tag == 0 {
            NSLog("\n코드로 생성된 스테퍼의 현재 값은 \(sender.value)")
        }else if sender.tag == 1 {
            NSLog("\n스토리보드로 생성된 스테퍼의 현재 값은 \(sender.value)")
        }
        
    }

}

