import UIKit

struct Feed:Decodable {
    let items:[Item]?
    
    static func downloadData(feedUrl:String, completion: @escaping ([Item]) -> Void) {
        let urlString = feedUrl
        let url = URL(string: urlString)
        
        if let urlObject = url {
            URLSession.shared.dataTask(with: urlObject) { (data, ressponse, error) in
                guard let data = data else { return }
                
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let feed = try decoder.decode(Feed.self, from: data)
                    guard let items = feed.items else { return }
                    
                    print("items: \(items)")
                    
                    DispatchQueue.main.async {
                        completion(items)
                    }
                    
                } catch let jsonErr {
                    print("we got an error \(jsonErr)")
                }
                }.resume()
        }
    }
}

struct Item:Decodable {
    let parentId:String?
    let title:String?
    let date:String?
    let venueName:String?
    let venueAddress:String?
    let startTime:String?
    let endTime:String?
    let parentCategoryName:String?
    let description:String?
}
