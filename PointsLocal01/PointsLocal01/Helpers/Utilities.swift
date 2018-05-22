import UIKit

func getCategoryColor(category:String) -> String {
    let categoryColors:[String:String] = [
        "Art Galleries & Exhibits": "#222",
        "Comedy": "#baba71",
        "Festivals": "#ae0000",
        "Food & Wine": "#666",
        "Outdoors & Recreation": "#003264"
    ]

    guard let color = categoryColors[category] else { return "#999" }
    
    return color
}

func stripHTML(copy:String) -> String {
    let bodyCopy = copy.replacingOccurrences(of: "<[^>]+>", with: "", options: String.CompareOptions.regularExpression, range: nil)
    return bodyCopy
}
