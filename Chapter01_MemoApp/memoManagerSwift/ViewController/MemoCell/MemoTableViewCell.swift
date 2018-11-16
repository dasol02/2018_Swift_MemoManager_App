import UIKit

class MemoTableViewCell: UITableViewCell {

    @IBOutlet weak var regdate: UILabel!    // 메모 제목
    @IBOutlet weak var contents: UILabel!   // 메모 내용
    @IBOutlet weak var subject: UILabel!    // 작성 일자
    @IBOutlet weak var img: UIImageView!    // 이미지
    
}
