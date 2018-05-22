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
                    let feed = try decoder.decode(Feed.self, from: data)
                    guard let items = feed.items else { return }
                    
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
    let parent_id:String?
    let title:String?
    let date:String?
    let venue_name:String?
    let venue_address:String?
    let start_time:String?
    let end_time:String?
    let parent_category_name:String?
    let description:String?
}
