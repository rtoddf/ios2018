import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        
//        let layout = UICollectionViewFlowLayout()
////        let feedController = FeedController(collectionViewLayout: layout)
//        let navigationController = UINavigationController(rootViewController: FeedController(collectionViewLayout: layout))
//        window?.rootViewController = navigationController
        
        window?.rootViewController = CustomTabBarController()

        UINavigationBar.appearance().barTintColor = UIColor(hexString: "#ae0000")
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        
        UITabBar.appearance().tintColor = UIColor(hexString: "#ffffff")
//        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedStringKey.foregroundColor: UIColor.green], for: .normal)
        
        
//        let selectedColor   = UIColor(red: 246.0/255.0, green: 155.0/255.0, blue: 13.0/255.0, alpha: 1.0)
//        let unselectedColor = UIColor(red: 16.0/255.0, green: 224.0/255.0, blue: 223.0/255.0, alpha: 1.0)
//
//        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedStringKey.foregroundColor: unselectedColor], for: .normal)
//        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedStringKey.foregroundColor: selectedColor], for: .selected)
        
        UITabBar.appearance().barTintColor = UIColor(hexString: "222222")
        
        application.statusBarStyle = .lightContent
        
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
    }


}

