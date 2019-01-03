import Foundation
import UIKit

//@UIApplicationMain -> 프로젝트에 1개만 생성 자동으로 프로젝트와 연결됨
@UIApplicationMain
class NewAppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        
        // 탭바 컨트롤러를 생성, 배경을 흰색으로 채운다
        let tbC = UITabBarController()
        tbC.view.backgroundColor = UIColor.white
        
        // 생성된 tbC를 루트뷰 컨트롤러로 등록한다.
        self.window?.rootViewController = tbC
        
        // 각 탭바 아이템에 연결될 뷰 컨트롤러 객체 생성
        
        let view01 = FirstViewController()
        let view02 = SecondViewController()
        let view03 = ThirdViewController()
        
        // 생성된 뷰 컨트롤러 객체들을 탭 바 컨트롤러에 등록
        tbC.setViewControllers([view01,view02,view03], animated: false)
        
        // 개별 탭바 아이템의 속성 설정
        
        view01.tabBarItem = UITabBarItem(title: "Calendar", image: UIImage(named: "calendar.png"), selectedImage: nil)
        view02.tabBarItem = UITabBarItem(title: "File", image: UIImage(named: "file-tree.png"), selectedImage: nil)
        view03.tabBarItem = UITabBarItem(title: "Photo", image: UIImage(named: "photo.png"), selectedImage: nil)

        return true
    }
    
    
    
    
}
