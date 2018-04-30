import UIKit

struct Article:Decodable {
    let category:String?
    let headline:String?
    let pub_date:String?
    let author:String?
    let summary:String?
    let full_text:String?
    let lead_image:String?
    let images:[Image]?
    let locations:[Location]?
    let related_content:[Item]?
    
    static func downloadData(completion: @escaping ([Article]) -> Void) {
        let urlString = "http://rtodd.net/swift/data/dawgnation01.json"
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

struct Image:Decodable {
    let path:String?
    let title:String?
    let caption:String?
    let credit:String?
}

struct Location:Decodable {
    let latitude:Float?
    let longitude:Float?
    let name:String?
}

struct Item:Decodable {
    let headline:String?
    let summary:String?
    let pub_date:String?
    let lead_image:String?
    let guid:String?
}
