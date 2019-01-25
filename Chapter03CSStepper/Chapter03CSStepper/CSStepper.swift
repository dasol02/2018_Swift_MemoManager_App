import UIKit

// 스토리보드에서 미리보기로 출력 가능하게 지원
@IBDesignable

class CSStepper: UIView {
    
    // 버튼 및 라벨 선언
    public var leftBtn = UIButton(type: UIButton.ButtonType.system)
    public var rightBtn = UIButton(type: UIButton.ButtonType.system)
    public var centerLabel = UILabel()
    public var value: Int = 0 //초기값 지정
    
    // 스토리 보드 호출시
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
    }
    
    // 코드로 호출시
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }
    
    // 초기화
    private func setup(){
        
        let borderWidth: CGFloat = 0.5
        let borderColor = UIColor.blue.cgColor
        
        
        // 좌측 버튼 설정
        self.leftBtn.tag = -1
        self.leftBtn.setTitle("⬇︎", for: UIControl.State.normal)
        self.leftBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        self.leftBtn.layer.borderWidth = borderWidth
        self.leftBtn.layer.borderColor = borderColor
        
        // 우측 버튼 설정
        self.rightBtn.tag = 1
        self.rightBtn.setTitle("⬆︎", for: UIControl.State.normal)
        self.rightBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        self.rightBtn.layer.borderWidth = borderWidth
        self.rightBtn.layer.borderColor = borderColor
        
        // 중앙 레이블 설정
        self.centerLabel.text = String(value) // 현재 값을 문자열로 변환하여 표시
        self.centerLabel.font = UIFont.systemFont(ofSize: 16)
        self.centerLabel.textAlignment = .center
        self.centerLabel.backgroundColor = UIColor.cyan
        self.centerLabel.layer.borderWidth = borderWidth
        self.centerLabel.layer.borderColor = borderColor
        
        
        // 화면에 추가
        self.addSubview(leftBtn)
        self.addSubview(rightBtn)
        self.addSubview(centerLabel)
    }
    
    // 뷰 크기에 따라 버튼과 레이블 크기 설정
    override public func layoutSubviews() {
        super.layoutSubviews()
        
        // 버튼 너비
        let btnWidth = self.frame.height
        // 레이블 너비
        let labelWidth = self.frame.width - (btnWidth * 2)
        
        self.leftBtn.frame = CGRect(x: 0, y: 0, width: btnWidth, height: btnWidth)
        self.centerLabel.frame = CGRect(x: btnWidth, y: 0, width: labelWidth, height: btnWidth)
        self.rightBtn.frame = CGRect(x: btnWidth+labelWidth, y: 0, width: btnWidth, height: btnWidth)
        
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
