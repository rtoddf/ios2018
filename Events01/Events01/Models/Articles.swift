import UIKit

struct Article:Decodable {
    let headline:String?
    let author:String?
    let full_text:String?
    let lead_image:String?
}

//
//struct Feed:Decodable {
//    let articles:[Article]?
//}
//
//struct Article:Decodable {
//    let items:[Item]?
//
//    static func downloadData(completion: @escaping ([Article]) -> Void
//        ){
//        let urlString = "http://www.rtodd.net/swift/data/events.json"
//        let url = URL(string: urlString)
//
//        if let urlObject = url {
//            URLSession.shared.dataTask(with: urlObject) { (data, response, error) in
//                guard let data = data else { return }
//
//                do {
//                    let feed = try JSONDecoder().decode(Feed.self, from: data)
//                    guard let articles = feed.articles else { return }
//                    DispatchQueue.main.async {
//                        completion(articles)
//                    }
//
//                } catch let jsonErr {
//                    print("we got an error \(jsonErr)")
//                }
//
//            }.resume()
//        }
//    }
//}
//
//struct Item:Decodable {
//    let headline:String?
//}

