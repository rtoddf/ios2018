import UIKit

class Category:NSObject {
    var name:String?
    var people:[Person]?
    
    static func samplePeopleCategories() -> [Category] {
        let actorCategory = Category()
        actorCategory.name = "Actors"
        
        var actors = [Person]()
        let actor01 = Person()
        actor01.name = "Ben Barnes"
        actor01.bio = "British actor and singer"
        actor01.birthDate = "20 August 1981"
        actor01.imageName = "ben-barnes"
        actors.append(actor01)
        actorCategory.people = actors
        
        let athleteCategory = Category()
        athleteCategory.name = "Athletes"
        
        var athletes = [Person]()
        let athlete01 = Person()
        athlete01.name = "Tom Daley"
        athlete01.bio = "British driver"
        athlete01.birthDate = "21 May 1994"
        athlete01.imageName = "tom-daley"
        athletes.append(athlete01)
        athleteCategory.people = athletes
        
        return [actorCategory, athleteCategory]
    }
}

class Person:NSObject {
    var name:String?
    var bio: String?
    var birthDate:String?
    var imageName:String?
}
