import UIKit

// 스토리보드에서 미리보기로 출력 가능하게 지원
@IBDesignable

class CSStepper: UIControl {
    
    // 버튼 및 라벨 선언
    public var leftBtn = UIButton(type: UIButton.ButtonType.system)
    public var rightBtn = UIButton(type: UIButton.ButtonType.system)
    public var centerLabel = UILabel()
    
    // 프로퍼티 옵저버 설정
    // 왼쪽 버튼 텍스트
    @IBInspectable // 스토리 보드에서 설정 가능하게 노출 지원
    public var leftBtnTitle: String = "⬇︎"{
        didSet{
            self.leftBtn.setTitle(leftBtnTitle, for: UIControl.State.normal)
        }
    }
    
    // 왼쪽 버튼 텍스트
    @IBInspectable
    public var rightBtnTitle: String = "⬆︎"{
        didSet{
            self.rightBtn.setTitle(rightBtnTitle, for: UIControl.State.normal)
        }
    }
    
    // 레이블 영역 색상
    @IBInspectable
    public var bgColor: UIColor = UIColor.cyan {
        didSet{
            self.centerLabel.backgroundColor = bgColor
        }
    }
    
    // 노출 값
    @IBInspectable
    public var value: Int = 0 { //초기값 지정
        didSet{
            self.centerLabel.text = String(value)
            
            // 현재값이 바뀔 경우 valueChanged이벤트 호출
            self.sendActions(for: UIControl.Event.valueChanged)
        }
    }
    
    // 버튼 증감값 단위
    @IBInspectable
    public var stepValue: Int = 1
    
    // 최댓값과 최솟값
    @IBInspectable public var maximumValue: Int = 100
    @IBInspectable public var minimumValue: Int = -100
    
    
// MARK: init
    
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
        self.leftBtn.setTitle(leftBtnTitle, for: UIControl.State.normal)
        self.leftBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        self.leftBtn.layer.borderWidth = borderWidth
        self.leftBtn.layer.borderColor = borderColor
        
        // 우측 버튼 설정
        self.rightBtn.tag = 1
        self.rightBtn.setTitle(rightBtnTitle, for: UIControl.State.normal)
        self.rightBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        self.rightBtn.layer.borderWidth = borderWidth
        self.rightBtn.layer.borderColor = borderColor
        
        // 중앙 레이블 설정
        self.centerLabel.text = String(value) // 현재 값을 문자열로 변환하여 표시
        self.centerLabel.font = UIFont.systemFont(ofSize: 16)
        self.centerLabel.textAlignment = .center
        self.centerLabel.backgroundColor = self.bgColor
        self.centerLabel.layer.borderWidth = borderWidth
        self.centerLabel.layer.borderColor = borderColor
        
        // 이벤트 연결
        self.leftBtn.addTarget(self, action: #selector(valueChange(_:)), for: UIControl.Event.touchUpInside)
        self.rightBtn.addTarget(self, action: #selector(valueChange(_:)), for: UIControl.Event.touchUpInside)
        
        // 화면에 추가
        self.addSubview(leftBtn)
        self.addSubview(rightBtn)
        self.addSubview(centerLabel)
    }
    
    // MARK: 변수 선언
    
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
    
    // MARK: Action
    // 버튼 이벤트에 따라 레이블 값 변경 메서드
    @objc public func valueChange(_ sender: UIButton){
        
        // 값 변경시 최댓, 최솟값 범위 유효 체크
        let sum = self.value + (sender.tag * self.stepValue)
        
        // 최댓값 보다 클 경우
        if sum > self.maximumValue {
            return
        }
        
        // 최솟값 보다 작을 경우
        if sum < self.minimumValue {
           return
        }
        
        // 현재 벨류값 수정
        self.value = sum
        
    }
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
