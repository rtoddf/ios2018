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
        actor01.short_bio = "British actor and singer"
        actor01.birth_date = "20 August 1981"
        actor01.image_name = "ben-barnes"
        actors.append(actor01)
        actorCategory.people = actors
        
        let athleteCategory = Category()
        athleteCategory.name = "Athletes"
        
        var athletes = [Person]()
        let athlete01 = Person()
        athlete01.name = "Tom Daley"
        athlete01.short_bio = "British driver"
        athlete01.birth_date = "21 May 1994"
        athlete01.image_name = "tom-daley"
        athletes.append(athlete01)
        athleteCategory.people = athletes
        
        return [actorCategory, athleteCategory]
    }
}

class Person:NSObject {
    var name:String?
    var short_bio: String?
    var birth_date:String?
    var image_name:String?
}
