import UIKit


class BaseViewController: UIViewController {
    static let FristViewController = "첫 번쨰 탭"
    static let SecondViewController = "두 번쨰 탭"
    static let ThirdViewController = "세 번째 탭"

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    func setMainContentTitlelabel(titleString : String){
        let title = UILabel(frame: CGRect(x: 0, y: 100, width: 100, height: 30))       // 크기 지정
        title.textColor = UIColor.red                                                 // 색상
        title.text = titleString                                                        // 타이틀 설정
        title.textAlignment = .center                                                 // 정렬
        title.font = UIFont.boldSystemFont(ofSize: 14)                                // 글자체
        title.sizeToFit()                                                             // 내용에 맞게 크기 변경
        title.center.x = self.view.frame.width / 2                                     // 라벨 화면 중앙 정렬
        self.view.addSubview(title)                                                   // 화면 추가
        
        var tabbarItemString : String!
        var tabbarImage : UIImage!
        
        
        switch titleString {
        case BaseViewController.FristViewController:
            tabbarItemString = "Calendar"
            tabbarImage = UIImage(named: "calendar.png")
            break
        case BaseViewController.SecondViewController:
            tabbarItemString = "File"
            tabbarImage = UIImage(named: "file-tree.png")
            break
        case BaseViewController.ThirdViewController:
            tabbarItemString = "Photo"
            tabbarImage = UIImage(named: "photo.png")
            break
        default: break
        }
        
        
        self.tabBarItem.image = tabbarImage
        self.tabBarItem.title = tabbarItemString
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
