import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUIAlertController() // 얼럿창 생성
    }
    
    
    
    //** UIAlertController 생성
    func setUIAlertController(){
        self.setUIAlertViewContentView()
//        self.setUIAlertViewOkCancel()
//        self.setUIAlertContentView() // 기본 얼럿창 컨텐츠뷰
//        self.setUIActionSheet() // 액션 시트 생성
    }
    
    
    //** 버튼 영역 추가
    func setUIAlertViewContentView(){
        let defaultAlerBtn = UIButton(type: .system)
        defaultAlerBtn.frame = CGRect(x: 0, y: 100, width: 100, height: 30)
        defaultAlerBtn.center.x = self.view.frame.width/2
        defaultAlerBtn.setTitle("기본 알림창", for: .normal)
        defaultAlerBtn.addTarget(self, action: #selector(defaultAlert(_:)), for: .touchUpInside)
        self.view.addSubview(defaultAlerBtn)
    }
    
    //** 컨텐츠 뷰 추가
    @objc func defaultAlert(_ sender: Any){
        let alert = UIAlertController(title: nil, message: "기본 메시지 들어가는 곳", preferredStyle: .alert)
        //TO DO : preferredStyle:.alert or preferredStyle:.actionSheet
        
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        
        let v = UIViewController()
        v.view.backgroundColor = UIColor.red
        alert.setValue(v, forKey: "contentViewController")
        
        self.present(alert, animated: true, completion: nil)
    }

/**
    // 컨텐츠 뷰 추가 얼럿창 기본
    func setUIAlertContentView(){
        let alert = UIAlertController(title: "Alert", message: "Check!", preferredStyle: .alert)
        let v = UIViewController()
        alert.setValue(v, forKey: "contentViewController")
        
        self.present(alert, animated: true, completion: nil)
    }
    
    
    // 기본 확인 및 취소 얼럿 뷰
    func setUIAlertViewOkCancel(){
        // 경고창
        let alert = UIAlertController(title: "Alert", message: "저장하시겠습니까?", preferredStyle: .alert)
        // 확인
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        // 취소
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    
    // 액션시트 생성
    func setUIActionSheet(){
        // 액션 시트
        let action = UIAlertController(title: "Action Sheet", message: "Choice Item", preferredStyle: .actionSheet)
    }
 
    
**/

    
}

