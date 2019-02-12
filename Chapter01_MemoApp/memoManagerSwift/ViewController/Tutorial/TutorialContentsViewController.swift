import UIKit

class TutorialContentsViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bgImageView: UIImageView!
    
    var pageIndex: Int!
    var titleText: String!
    var imageFile: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // 전달받은 타이틀 정보 객체 대입 및 크기 조절
        self.titleLabel.text = self.titleText
        self.titleLabel.sizeToFit()
        
        // 전달받은 이미지를 이미지 뷰에 적용
        self.bgImageView.image = UIImage(named: self.imageFile)
    
    }
    
}
