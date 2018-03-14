import UIKit

struct Person:Decodable {
    let name:String?
    var description:String?
    var profileImage:String?
    var statusImage:String?
    var statusText:String?
    var subStatusText:String?
}
