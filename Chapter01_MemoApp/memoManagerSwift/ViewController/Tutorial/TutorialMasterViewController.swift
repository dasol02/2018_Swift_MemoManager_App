import UIKit

class TutorialMasterViewController: UIViewController, UIPageViewControllerDataSource {

    var pageVC : UIPageViewController!

    var contentTitles = ["STEP1", "STEP2", "STEP3", "STEP4"]
    var contentImages = ["page0", "page1", "page2", "page3"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 뷰 페이지 컨트롤러 설정
        self.initPageController()

    }
    
    // 뷰 페이지 컨트롤러 설정
    private func initPageController(){
        
        // 페이지 뷰 컨트롤러 객체 생성
        self.pageVC = self.instanceTutorialVC(name: "PageVC") as? UIPageViewController
        self.pageVC.dataSource = self
        
        // 최초 노출 컨텐츠 뷰 지정
        let startContentVC = self.getContentVC(atIndex: 0)!
        self.pageVC.setViewControllers([startContentVC], direction: UIPageViewController.NavigationDirection.forward, animated: true, completion: nil)
        
        // 페이지 뷰 컨트롤러의 출력 영역 지정
        self.pageVC.view.frame.origin = CGPoint(x: 0, y: 0)
        self.pageVC.view.frame.size.width = self.view.frame.width
        self.pageVC.view.frame.size.height = self.view.frame.height - 50
        
        // 페이지 뷰 컨트롤러를 마스터 뷰 컨트롤러의 자식 뷰 컨트롤러로 설정
        self.addChild(self.pageVC)
        self.view.addSubview(self.pageVC.view)
        self.view.sendSubviewToBack(self.pageVC.view)
        self.pageVC.didMove(toParent: self)
    }
    
    // MARK: Action
    @IBAction func close(_ sender: Any) {
        let ud = UserDefaults.standard
        ud.set(true, forKey: UserInfoKey.tutorial)
        ud.synchronize()
        
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    
    // MARK: Extension UIViewController (tutorialSB)
    func getContentVC(atIndex idx: Int) -> UIViewController? {
        
        // 인덱스가 데이터 배열 크기 범위를 벗어나면 nil 반환
        guard self.contentImages.count >= idx && self.contentTitles.count > 0 else{
            return nil
        }
        
        // ContentsVC가 Stroyboard에 없을경우 nil 반환
        guard let cvc = self.instanceTutorialVC(name: "ContentsVC") as? TutorialContentsViewController else {
            return nil
        }
        
        // 콘텐츠 뷰 내용 구성
        cvc.titleText = self.contentTitles[idx]
        cvc.imageFile = self.contentImages[idx]
        cvc.pageIndex = idx
        
        return cvc
    }
    
    
    // MARK: UIPageViewController Delegate
    // 현재의 뷰컨트롤러 보다 앞쪽에 올 컨트롤러 객체
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        // 현재 페이지의 인덱스 호출시
        guard var index = (viewController as! TutorialContentsViewController).pageIndex else {
            return nil
        }
        
        // 현재 페이지가 맨 앞이라면
        guard index > 0 else {
            return nil
        }
        
        // 이전 페이지 인덱스 설정
        index -= 1
        
        return self.getContentVC(atIndex: index)
        
    }
    
    // 현재의 콘텐츠 보다 뒤쪽에 올 컨트롤러 객체
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        // 현재 페이지의 인덱스 호출시
        guard var index = (viewController as! TutorialContentsViewController).pageIndex else {
            return nil
        }
        
        index += 1
        
        // 현재 페이지가 맨 앞이라면
        guard index < self.contentTitles.count else {
            return nil
        }
        
        
        return self.getContentVC(atIndex: index)
        
    }

    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 0
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return self.contentTitles.count
    }
}
