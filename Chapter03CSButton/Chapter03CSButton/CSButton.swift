import UIKit

class CSButton: UIButton {

    
    // 스토리 보드 생성시 호출
    required init?(coder aDecoder: NSCoder) {
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


    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
