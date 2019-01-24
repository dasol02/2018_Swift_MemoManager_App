import UIKit

class CSButton: UIButton {

    public enum CSButtonType {
        case rect
        case circle
    }
    
// 클래스내 프로퍼티 값 변경시 호출
    var style: CSButtonType = .rect {
    //  willSet    : 변경되기 직전
        didSet{ // : 변경된 이후
            switch style {
            case .rect:
                self.backgroundColor = UIColor.black
                self.layer.borderColor = UIColor.black.cgColor
                self.layer.borderWidth = 2
                self.layer.cornerRadius = 0
                self.setTitleColor(UIColor.white, for: UIControl.State.normal)
                self.setTitle("Rect Button", for: UIControl.State.normal)
                break
            case .circle:
                self.backgroundColor = UIColor.red
                self.layer.borderColor = UIColor.blue.cgColor
                self.layer.borderWidth = 2
                self.layer.cornerRadius = 50
                self.setTitle("Circle Button", for: UIControl.State.normal)
                break
            }
        }
    }
    
    
// init 초기화 메서드
    convenience init (type: CSButtonType ){
        self.init()
        
        switch type {
        case .rect:
            self.backgroundColor = UIColor.black
            self.layer.borderColor = UIColor.black.cgColor
            self.layer.borderWidth = 2
            self.layer.cornerRadius = 0
            self.setTitleColor(UIColor.white, for: UIControl.State.normal)
            self.setTitle("Rect Button", for: UIControl.State.normal)
            break
        case .circle:
            self.backgroundColor = UIColor.red
            self.layer.borderColor = UIColor.blue.cgColor
            self.layer.borderWidth = 2
            self.layer.cornerRadius = 50
            self.setTitle("Circle Button", for: UIControl.State.normal)
            break
        }
        
        self.addTarget(self, action: #selector(counting(_:)), for: UIControl.Event.touchUpInside)
    }
    
    // 스토리 보드 생성시 호출
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!

        self.custonButtonSetting(title: "스토리보드 생성 버튼")
    }
    
    
    // 코드로 생성시 호출
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.custonButtonSetting(title: "코드 생성 버튼")
        
    }
    
    init(){
        super.init(frame: CGRect.zero)
          self.custonButtonSetting(title: "코드 생성 버튼")
    }

    func custonButtonSetting(title : String){
        // 커스텀 설정
        self.backgroundColor   = UIColor.green               // 배경
        self.layer.borderWidth = 2                           // 테두리 선
        self.layer.borderColor = UIColor.black.cgColor       // 테두리 색
        self.setTitle(title, for: UIControl.State.normal)    // 버튼 텍스트
    }

    
    @objc func counting(_ sender: UIButton){
        sender.tag = sender.tag + 1
        sender.setTitle("\(sender.tag) 번째 클릭", for: UIControl.State.normal)
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
