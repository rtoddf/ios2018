import UIKit

class CustomTabBarController:UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layout = UICollectionViewFlowLayout()
        //        let feedController = FeedController(collectionViewLayout: layout)
        let navigationController = UINavigationController(rootViewController: FeedController(collectionViewLayout: layout))
        navigationController.title = "News Feed"
        navigationController.tabBarItem.image = UIImage(named: "home")
        
        let friendRequestController = FriendRequestsController()
        friendRequestController.navigationItem.title = "Friends"
        let secondNavigationController = UINavigationController(rootViewController: friendRequestController)
        secondNavigationController.title = "Requests"
        secondNavigationController.tabBarItem.image = UIImage(named: "home")
        
        let messengerController = FriendRequestsController()
        messengerController.navigationItem.title = "Messenger"
        let thirdNavigationController = UINavigationController(rootViewController: messengerController)
        thirdNavigationController.title = "Messenger"
        thirdNavigationController.tabBarItem.image = UIImage(named: "home")
        
        let notificationsController = FriendRequestsController()
        notificationsController.navigationItem.title = "Notifications"
        let fourthNavigationController = UINavigationController(rootViewController: notificationsController)
        fourthNavigationController.title = "Notifications"
        fourthNavigationController.tabBarItem.image = UIImage(named: "home")
        
        let moreController = FriendRequestsController()
        moreController.navigationItem.title = "More"
        let fifthNavigationController = UINavigationController(rootViewController: moreController)
        fifthNavigationController.title = "More"
        fifthNavigationController.tabBarItem.image = UIImage(named: "home")
        
        viewControllers = [navigationController, secondNavigationController, thirdNavigationController, fourthNavigationController, fifthNavigationController]
    
        tabBar.isTranslucent = false
        
        let topBorder = CALayer()
        topBorder.frame = CGRect(x: 0, y: 0, width: 1000, height: 0.5)
        topBorder.backgroundColor = UIColor(hexString: "#ae0000").cgColor
        
        tabBar.layer.addSublayer(topBorder)
        tabBar.clipsToBounds = true
    }
}
