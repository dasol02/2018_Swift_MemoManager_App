import UIKit
import CoreData

//@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        if let tBC = self.window?.rootViewController as? UITabBarController {
            if let tbItems = tBC.tabBar.items {
                // 커스텀 탭바 아이콘 추가 (탭바 사이즈에 맞게)
//                tbItems[0].image = UIImage(named: "calendar.png")
//                tbItems[1].image = UIImage(named: "file-tree.png")
//                tbItems[2].image = UIImage(named: "photo.png")
                
                // 이미지 원본으로 사용할 경우
                tbItems[0].image = UIImage(named: "designbump@2x.png")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
                tbItems[1].image = UIImage(named: "rss@2x.png")?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
                tbItems[2].image = UIImage(named: "facebook@2x.png")?.withRenderingMode(UIImage.RenderingMode.automatic)
                
                
                // for 문 사용 클릭시 탭바 설정
//                for tbItem in tbItems {
//                    //이미지 설정
//                    let image = UIImage(named: "checkmark")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
//                    tbItem.selectedImage = image
//
//                    // 텍스트 설정
//
//                    // 색상
//                    tbItem.setTitleTextAttributes([NSAttributedString.Key(rawValue: NSAttributedString.Key.foregroundColor.rawValue) : UIColor.gray], for: UIControl.State.disabled)
//                    tbItem.setTitleTextAttributes([NSAttributedString.Key(rawValue: NSAttributedString.Key.foregroundColor.rawValue) : UIColor.red], for: UIControl.State.selected)
//
//                    // 크기
//                    tbItem.setTitleTextAttributes([NSAttributedString.Key(rawValue: NSAttributedString.Key.font.rawValue) : UIFont.systemFont(ofSize: 15)], for: UIControl.State.normal)
//                }
                
                
                // 탭바 타이틀 입력
                tbItems[0].title = "Calendar"
                tbItems[1].title = "File"
                tbItems[2].title = "Photo"
                
                
                
                // 탭바 전체 속성 일괄 변경
                let tbItemProxy = UITabBarItem.appearance()
                tbItemProxy.setTitleTextAttributes([NSAttributedString.Key(rawValue: NSAttributedString.Key.foregroundColor.rawValue) : UIColor.red], for: UIControl.State.selected)
                tbItemProxy.setTitleTextAttributes([NSAttributedString.Key(rawValue: NSAttributedString.Key.foregroundColor.rawValue) : UIColor.gray], for: UIControl.State.disabled)
                tbItemProxy.setTitleTextAttributes([NSAttributedString.Key(rawValue: NSAttributedString.Key.font.rawValue) : UIFont.systemFont(ofSize: 15)], for: UIControl.State.normal)
                
                let tbProxy = UITabBar.appearance()
                tbProxy.tintColor = UIColor.white
                tbProxy.backgroundImage = UIImage(named: "menubar-bg-mini.png")
                
            }
            
            // 탭바 아이템의 이미지 색상을 변경
//            tBC.tabBar.tintColor = UIColor.white
            
            let a = 0
            switch a {
                case 1:
                    // 탭바 배경 추가 (이미지 좌우 크기가 모자를 경우 알아서 반복하여 늘어난다)
                    tBC.tabBar.backgroundImage = UIImage(named: "menubar-bg-mini.png")
                    break;
                case 2:
                    tBC.tabBar.backgroundImage = UIImage(named: "connectivity-bar.png")
                    break;
                case 3:
                    // 탭바 배경 이미지 추가 (이미지의 좌우간격 수동 늘림)
                    let image = UIImage(named: "connectivity-bar.png")?.stretchableImage(withLeftCapWidth: 5, topCapHeight: 16)
                    tBC.tabBar.backgroundImage = image
                    break;
                case 4:
                    // 탭바 배경 이미지 추가 (이미지의 상하 간격 수동 늘림)
                    let image = UIImage(named: "connectivity-bar.png")?.stretchableImage(withLeftCapWidth: 0, topCapHeight: 0)
                    tBC.tabBar.backgroundImage = image
                    break;
                case 5:
                    // 배경 색상 변경
                    tBC.tabBar.barTintColor = UIColor.black
                    break;
                case 6:
                    // 배경 이미지를 틴트 컬러에 추가
                    let image = UIImage(named: "menubar-bg-mini.png")!
                    tBC.tabBar.barTintColor = UIColor(patternImage: image)
                    break;
                default:
                    break;
            }
        }
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "Chapter03TabBar")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}

