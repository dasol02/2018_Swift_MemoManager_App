import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.setData()
        self.getData()
    }
    
    // UserDefault 데이터 저장
    func setData(){
        
        let plist = UserDefaults.standard
        
        plist.set("홍길동", forKey: "이름")
        plist.set(24, forKey: "나이")
        plist.set("남", forKey: "성별")
        
        plist.synchronize()
    }
    
    // UserDefault 데이터 로드
    func getData(){
        
        let plist = UserDefaults.standard
        
        let name = plist.string(forKey: "이름")
        let age = plist.integer(forKey: "나이")
        let sex = plist.object(forKey: "성별") as? NSString
        
        print("name = \(name)\nage = \(age)\nsex = \(String(describing: sex))")
    }


}

