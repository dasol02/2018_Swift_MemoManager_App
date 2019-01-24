import UIKit

class ControlViewController: UIViewController {
    
    // 슬라이더 객체 생성
    private let slider = UISlider()

    // 슬라이더 값 연산 프로퍼티
    var sliderValue : Float {
        return self.slider.value
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // 슬라이더의 최솟값 / 최댓값 설정
        self.slider.minimumValue = 0
        self.slider.maximumValue = 100
        
        // 슬라이더의 영역과 크기를 정의하고 루트 뷰에 추가
        self.slider.frame = CGRect(x: 0, y: 0, width: 170, height: 30)
        self.view.addSubview(slider)
        
        // 뷰컨 사이즈 지정
        self.preferredContentSize = CGSize(width: self.slider.frame.size.width, height: self.slider.frame.size.height+15)
        
    }

}
