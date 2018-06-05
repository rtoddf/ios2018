import UIKit

struct MenuItems:Decodable {
    let menuItems:[Menu]?
    
    static func downloadData(feedUrl:String, completion: @escaping ([Menu]) -> Void) {
        let urlString = feedUrl
        let url = URL(string: urlString)
        
        if let urlObject = url {
            URLSession.shared.dataTask(with: urlObject) { (data, ressponse, error) in
                guard let data = data else { return }
                
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let feed = try decoder.decode(MenuItems.self, from: data)
                    let menu = feed.menuItems

                    DispatchQueue.main.async {
                        guard let dataMenu = menu else { return }
                        
                        completion(dataMenu)
                    }
                    
                } catch let jsonErr {
                    print("we got an error \(jsonErr)")
                }
                }.resume()
        }
    }
}

struct Menu:Decodable {
    let title:String?
}

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

struct Events:Decodable {
    private enum CodingKeys:String, CodingKey {
        case events = "items"
    }
    
    let events:[Item]?

    static func downloadData(feedUrl:String, completion: @escaping ([Item]) -> Void) {
        let urlString = feedUrl
        let url = URL(string: urlString)
        
        if let urlObject = url {
            URLSession.shared.dataTask(with: urlObject) { (data, ressponse, error) in
                guard let data = data else { return }
                
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let feed = try decoder.decode(Events.self, from: data)
                    guard let events = feed.events else { return }
                    
                    DispatchQueue.main.async {
                        completion(events)
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
    let headline:String?
    let date:String?
    let venueName:String?
    let venueAddress:String?
    let startTime:String?
    let endTime:String?
    let parentCategoryName:String?
    let fullText:String?
    
    private enum CodingKeys:String, CodingKey {
        case parentId, date, venueName, venueAddress, startTime, endTime, parentCategoryName
        case headline = "title"
        case fullText = "description"
    }
}

struct Weather:Decodable {
    let daily : Daily
    let city:City?
    let currentConditions:CurrentConditions?
    
    private enum CodingKeys:String, CodingKey {
        case daily, currentConditions
        case city = "City"
    }
    
    static func downloadData(feedUrl:String, completion: @escaping (CurrentConditions, [Day]) -> Void) {
        let urlString = feedUrl
        let url = URL(string: urlString)
        
        if let urlObject = url {
            URLSession.shared.dataTask(with: urlObject) { (data, ressponse, error) in
                guard let data = data else { return }
                
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let feed = try decoder.decode(Weather.self, from: data)
                    
                    let daily = feed.daily
                    let city = feed.city
                    let currentConditions = feed.currentConditions
                    
                    var dailyConditions = [Day]()
                    dailyConditions.append(daily.zero)
                    dailyConditions.append(daily.one)
                    dailyConditions.append(daily.two)
                    dailyConditions.append(daily.three)
                    dailyConditions.append(daily.four)
                    dailyConditions.append(daily.five)
                    dailyConditions.append(daily.six)
                    dailyConditions.append(daily.seven)
                    dailyConditions.append(daily.eight)
                    dailyConditions.append(daily.nine)

//                    print("city: \(city)")
                    
                    DispatchQueue.main.async {
                        guard let currentConditions = currentConditions else { return }
                        completion(currentConditions, dailyConditions)
                    }
                    
                } catch let jsonErr {
                    print("we got an error \(jsonErr)")
                }
                }.resume()
        }
    }
}

struct City:Decodable {
    let name:String?
    let stateAbbreviation:String?
    let latitude:String?
    let longitude:String?
    
    private enum CodingKeys:String, CodingKey {
        case name = "Name"
        case stateAbbreviation = "StateAbbreviation"
        case latitude = "Latitude"
        case longitude = "Longitude"
    }
}

struct CurrentConditions:Decodable {
    let tempF:Int?
    let sky:String?
    let feelsLikeF:Int?
    let report_time_utc:String?
    let iconCode:Int?
//    let gust:Int?
    let visibility:Int?
    let humidity:Int?
    
    private enum CodingKeys:String, CodingKey {
        case report_time_utc, visibility, humidity
        case tempF = "TempF"
        case sky = "Sky"
        case feelsLikeF = "FeelsLikeF"
        case iconCode = "IconCode"
//        case gust = "Gust"
    }
}

struct Daily:Decodable {
    private enum CodingKeys : String, CodingKey {
        case zero = "0"
        case one = "1"
        case two = "2"
        case three = "3"
        case four = "4"
        case five = "5"
        case six = "6"
        case seven = "7"
        case eight = "8"
        case nine = "9"
    }
    let zero:Day
    let one:Day
    let two:Day
    let three:Day
    let four:Day
    let five:Day
    let six:Day
    let seven:Day
    let eight:Day
    let nine:Day
}

struct Day:Decodable {
    let skyCode:Int?
    let skyText:String?
    let validDateLocal:String?
    let iconCode:Int?
    let windSpeedMph:Int?
    let hiTempF:Int?
    let loTempF:Int?
    let sunset:String?
    let sunrise:String?
    let precipChance:Int?
    
    private enum CodingKeys:String, CodingKey {
        case skyCode = "SkyCode"
        case skyText = "SkyText"
        case validDateLocal = "ValidDateLocal"
        case iconCode = "IconCode"
        case windSpeedMph = "WindSpeedMph"
        case hiTempF = "HiTempF"
        case loTempF = "LoTempF"
        case sunset = "Sunset"
        case sunrise = "Sunrise"
        case precipChance = "PrecipChance"
    }
}
