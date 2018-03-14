import UIKit

class AppCategory:NSObject {
    var name:String?
    var apps:[App]?
    
    static func sampleAppCategories() -> [AppCategory] {
        let actorsOneCategory = AppCategory()
        actorsOneCategory.name = "Actors One"
        var actorOneApps = [App]()

        let actorOne = App()
        actorOne.name = "Nico Tortorella"
        actorOne.info = "American actor and model"
        actorOne.date = "July 30, 1988"
        actorOne.imageName = "nico"
        actorOneApps.append(actorOne)
        actorsOneCategory.apps = actorOneApps
        
        let actorsTwoCategory = AppCategory()
        actorsTwoCategory.name = "Actors Two"
        var actorTwoApps = [App]()
        
        let actorTwo = App()
        actorTwo.name = "Ben Barnes"
        actorTwo.info = "British actor and singer"
        actorTwo.date = "20 August 1981"
        actorTwo.imageName = "ben_barnes"
        actorTwoApps.append(actorTwo)
        actorsTwoCategory.apps = actorTwoApps
        
        actorsTwoCategory.apps = actorTwoApps
        
        return [actorsOneCategory, actorsTwoCategory]
    }
}

class App:NSObject {
    var name:String?
    var info:String?
    var date:String?
    var imageName:String?
}
