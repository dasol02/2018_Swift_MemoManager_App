import UIKit

class MapAlertViewController: UIViewController {
    
    func didSelectRowAt(indexPath:IndexPath){
        print("선택된 행은 \(indexPath.row)입니다.")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 맵 얼럿뷰 버튼 생성
        let alertBtnMap = UIButton(type: .system)
        alertBtnMap.frame = CGRect(x: 0, y: 150, width: 100, height: 30)
        alertBtnMap.center.x = self.view.frame.width / 2
        alertBtnMap.setTitle("Map Alert", for: .normal)
        alertBtnMap.addTarget(self, action: #selector(mapAlert(_:)), for: .touchUpInside)
        
        
        // 이미지 얼럿뷰 버튼 생성
        let alertBtnImage = UIButton(type: .system)
        alertBtnImage.frame = CGRect(x: 0, y: 200, width: 100, height: 30)
        alertBtnImage.center.x = self.view.frame.width / 2
        alertBtnImage.setTitle("Image Alert", for: .normal)
        alertBtnImage.addTarget(self, action: #selector(imageAlert(_:)), for: .touchUpInside)
        
        
        // 슬라이더 얼럿뷰 버튼 생성
        let alertBtnSlider = UIButton(type: .system)
        alertBtnSlider.frame = CGRect(x: 0, y: 250, width: 100, height: 30)
        alertBtnSlider.center.x = self.view.frame.width / 2
        alertBtnSlider.setTitle("Slider Alert", for: .normal)
        alertBtnSlider.addTarget(self, action: #selector(sliderAlert(_:)), for: .touchUpInside)
        
        
        // 리시트 얼럿뷰 버튼 생성
        let alertBtnList = UIButton(type: .system)
        alertBtnList.frame = CGRect(x: 0, y: 300, width: 100, height: 30)
        alertBtnList.center.x = self.view.frame.width / 2
        alertBtnList.setTitle("List Alert", for: .normal)
        alertBtnList.addTarget(self, action: #selector(listAlert(_:)), for: .touchUpInside)
        
        
        //화면에 추가
        self.view.addSubview(alertBtnImage)
        self.view.addSubview(alertBtnMap)
        self.view.addSubview(alertBtnSlider)
        self.view.addSubview(alertBtnList)
    }
    
    // 슬라이더 얼럿뷰 생성
    @objc func listAlert(_ sender:UIButton){
        
        // 컨텐츠 뷰 영역에 들어갈 뷰 컨트롤러 생성
        let contentVC = ListViewController()
        contentVC.delegate = self;
        
        // 얼럿창 생성
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
        
        // 얼럿창 내부 컨텐츠 등록
        alert.setValue(contentVC, forKey: "contentViewController")
        
        // 액션 이벤트 추가
        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
        alert.addAction(okAction)
        
        // 화면 생성
        self.present(alert, animated: false, completion: nil)
    }
    
    
    // 슬라이더 얼럿뷰 생성
    @objc func sliderAlert(_ sender:UIButton){
        
        // 컨텐츠 뷰 영역에 들어갈 뷰 컨트롤러 생성
        let contentVC = ControlViewController()
        
        // 얼럿창 생성
        let alert = UIAlertController(title: nil, message: "이번 글의 평점은 다음과 같습니다.", preferredStyle: .alert)
        
        // 얼럿창 내부 컨텐츠 등록
        alert.setValue(contentVC, forKey: "contentViewController")
        
        // 액션 이벤트 추가
        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) { (_) in
            print("Slider Value == \(contentVC.sliderValue)")
        }
        alert.addAction(okAction)
        
        // 화면 생성
        self.present(alert, animated: false, completion: nil)
    }
    
    
    // 이미지 얼럿뷰 생성
    @objc func imageAlert(_ sender:UIButton){
        
        let alert = UIAlertController(title: nil, message: "이번 글의 평점은 다음과 같습니다.", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        
        // 컨텐츠 뷰 영역에 들어갈 뷰 컨트롤러 생성, 알림창 등록
        let contentVC = ImageViewController()
        alert.setValue(contentVC, forKey: "contentViewController")
        self.present(alert, animated: false, completion: nil)
    }
    
    // 맵 얼럿뷰 샐성
    @objc func mapAlert(_ sender:UIButton){
        
        let alert = UIAlertController(title: nil, message: "여기가 맞습니까?", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        alert.addAction(cancelAction)
        alert.addAction(okAction)
        
        // 컨텐츠 뷰 영역에 들어갈 뷰 컨트롤러 생성, 알림창 등록
        let contentVC = MapKitViewController()
        alert.setValue(contentVC, forKey: "contentViewController")
        self.present(alert, animated: false, completion: nil)
        
    }
}
