import UIKit

struct Article:Decodable {
    let headline:String?
    let pub_date:String?
    let author:String?
    let summary:String?
    let full_text:String?
    let lead_image:String?
    
    static func downloadData(completion: @escaping ([Article]) -> Void) {
        let urlString = "http://rtodd.net/swift/data/music-reviews.json"
        let url = URL(string: urlString)
        
        if let urlObject = url {
            URLSession.shared.dataTask(with: urlObject) { (data, response, error) in
                guard let data = data else { return }
                
                do {
                    let articles = try JSONDecoder().decode([Article].self, from: data)

                    DispatchQueue.main.async {
                        completion(articles)
                    }
                    
                } catch let jsonErr {
                    print("we got an error \(jsonErr)")
                }
                
            }.resume()
        }
    }
}
