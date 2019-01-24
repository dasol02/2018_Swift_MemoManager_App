import UIKit

class CSTabBarViewController: UITabBarController {
    
    let csView = UIView()
    let tabitem01 = UIButton(type: UIButton.ButtonType.system)
    let tabitem02 = UIButton(type: UIButton.ButtonType.system)
    let tabitem03 = UIButton(type: UIButton.ButtonType.system)

    override func viewDidLoad() {
        super.viewDidLoad()

        // 기존 탭바 숨김 처리
        self.tabBar.isHidden = true
        
        // 새로운 탭바 크기 및 영역 처리
        let width = self.view.frame.width
        let height:CGFloat = 50
        let x: CGFloat = 0
        let y = self.view.frame.height - height
        
        // 새로운 탭바를 화면에 추가
        self.csView.frame = CGRect(x: x, y: y, width: width, height: height)
        self.csView.backgroundColor = UIColor.brown
        self.view.addSubview(self.csView)
        
        
        // 탭바 버튼 너비 및 높이 설정
        let tabBtnWidth = self.csView.frame.size.width/3
        let tabBtbHeight = self.csView.frame.size.height
        
        // 버튼 영역 설정
        self.tabitem01.frame = CGRect(x: 0, y: 0, width: tabBtnWidth, height: tabBtbHeight)
        self.tabitem02.frame = CGRect(x: tabBtnWidth, y: 0, width: tabBtnWidth, height: tabBtbHeight)
        self.tabitem03.frame = CGRect(x: tabBtnWidth*2, y: 0, width: tabBtnWidth, height: tabBtbHeight)
        
        // 버튼 속성 및 탭바 영역에 추가
        self.addTabBarBtn(btn: self.tabitem01, title: "첫 번쨰 버튼", tag: 0)
        self.addTabBarBtn(btn: self.tabitem02, title: "두 번쨰 버튼", tag: 1)
        self.addTabBarBtn(btn: self.tabitem03, title: "세 번쨰 버튼", tag: 2)
        
        self.onTabbarItemClick(self.tabitem01)
    }
    

    // 버튼 속성 설정 및 화면에 추가
    func addTabBarBtn(btn: UIButton, title:String, tag: Int){
        
        // 타이틀
        btn.setTitle(title, for: UIControl.State.normal)
        
        // 버튼 태크값
        btn.tag = tag
        
        // 텍스트 컬러
        btn.setTitleColor(UIColor.white, for: UIControl.State.normal)
        btn.setTitleColor(UIColor.yellow, for: UIControl.State.selected)
        
        // 액션 이벤트
        btn.addTarget(self, action: #selector(onTabbarItemClick(_:)), for: UIControl.Event.touchUpInside)
        
        // 화면에 추가
        self.csView.addSubview(btn)
    }
    
    // 탭바 버튼 클릭 이벤트
    @objc func onTabbarItemClick(_ sender:UIButton){
        
        // 이전 버튼 선택 여부 초기화
        self.tabitem01.isSelected = false
        self.tabitem02.isSelected = false
        self.tabitem03.isSelected = false
        
        // 현재 클릭된 버튼 선택 설정
        sender.isSelected = true
        
        // 현재 페이지 설정
        self.selectedIndex = sender.tag
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
