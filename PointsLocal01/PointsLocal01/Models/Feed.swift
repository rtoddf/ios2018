import UIKit

struct Feed:Decodable {
    let items:[Item]?
}

struct Item:Decodable {
    let parent_id:String?
    let title:String?
    let date:String?
    let venue_name:String?
    let start_time:String?
    let end_time:String?
    let parent_category_name:String?
    
    static func downloadData(completion: @escaping ([Item]) -> Void) {
        let urlString = "https://dayton.pointslocal.com/api/v1/events?date_format=F%20j,%20Y&time_format=g:i%20a&search=festival&tag=&category=&latitude=39.7794694&longitude=-84.2721968&radius=25&start=today&end=+30%20days&count=6"
        let url = URL(string: urlString)
    
        if let urlObject = url {
            URLSession.shared.dataTask(with: urlObject) { (data, ressponse, error) in
                guard let data = data else { return }
                
                do {
                    let feed = try JSONDecoder().decode(Feed.self, from: data)
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
