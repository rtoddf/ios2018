import UIKit

extension UIView {
    func addConstraintsWithFormat(format:String, views:UIView...) {
        var viewsDictionary = [String: UIView]()
        for (index, view) in views.enumerated() {
            let key = "v\(index)"
            view.translatesAutoresizingMaskIntoConstraints = false
            viewsDictionary[key] = view
        }
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutFormatOptions(), metrics: nil, views: viewsDictionary))
    }
}

extension UIColor {
    convenience init(hexString:String, alpha:CGFloat = 1.0) {
        let hexString:String = hexString.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        let scanner = Scanner(string: hexString)
        
        if hexString.hasPrefix("#") {
            scanner.scanLocation = 1
        }
        
        var color:UInt32 = 0
        scanner.scanHexInt32(&color)
        
        let mask = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask
        
        let red = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue = CGFloat(b) / 255.0
        
        self.init(red:red, green:green, blue:blue, alpha:alpha)
    }
    
    func toHexString() -> String {
        var r:CGFloat = 0
        var g:CGFloat = 0
        var b:CGFloat = 0
        var a:CGFloat = 0
        
        getRed(&r, green: &g, blue: &b, alpha: &a)
        let rgb:Int = (Int)(r*255)<<16 | (Int)(g*255)<<8 | (Int)(b*255)<<0
        return String(format:"#%06x", rgb)
    }
    
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1.0)
    }
}

extension UIImageView {
    func loadImageUsingUrlString(imageUrl:String) {
        let imageNameSplit = imageUrl.components(separatedBy: "/")
        let savedImageName = imageNameSplit.last
        
        let url = URL(string: imageUrl)!
        let request = NSMutableURLRequest(url: url)
        
        // restores from memory if downloaded
        let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        if documentsPath.count > 0 {
            let documentsDirectory = documentsPath[0]
            guard let savedImageName = savedImageName else { return }
            
            let restorePath = documentsDirectory + savedImageName
            self.image = UIImage(contentsOfFile: restorePath)
        }
        
        // downloads the image the first time
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            data, response, error in
            
            if error != nil {
                print(error as Any)
            } else {
                guard let data = data else { return }
                guard let image = UIImage(data: data) else { return }
                
                DispatchQueue.main.async { // Correct - https://developer.apple.com/documentation/code_diagnostics/main_thread_checker
                    self.image = image
                    
                    // searches for documents path
                    let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
                    // should return one, but we just make sure
                    if documentsPath.count > 0 {
                        guard let savedImageName = savedImageName else { return }
                        
                        let documentsDirectory = documentsPath[0]
                        let savePath = documentsDirectory + savedImageName
                        
                        do {
                            try UIImageJPEGRepresentation(image, 1)?.write(to: URL(fileURLWithPath: savePath))
                        } catch {
                            // process the error
                        }
                        
                        // another way
                        // FileManager.default.createFile(atPath: savePath, contents: data, attributes: nil)
                    }
                }
                
            }
        }
        task.resume()
    }
}

extension NSMutableAttributedString {
    @discardableResult func format(string:String, font:String, textSize:CGFloat, textColor:UIColor, linespacing: CGFloat) -> NSMutableAttributedString {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = linespacing  // Whatever line spacing you want in points
        let font:UIFont = (UIFont(name: font, size: textSize))!
        
        let attrs: [NSAttributedStringKey: Any] = [
            .paragraphStyle: paragraphStyle,
            .font : font,
            .foregroundColor: textColor
        ]
        
        let boldString = NSMutableAttributedString(string: string, attributes: attrs)
        append(boldString)
        
        return self
    }
}

extension String {
    func wrapHTML() -> String {
        let fontSize:String = "24px"
        
        var headHtml = """
        <html>
        <head>
        <meta name=\"viewport\" content=\"width=device-width, user-scalable=no, shrink-to-fit=no\">
        <style type=\"text/css\">
        body {
        -webkit-text-size-adjust: %ld%;
        font-family: -apple-system, BlinkMacSystemFont, sans-serif;
        width: 100%;
        font-size: \(fontSize);
        word-wrap: break-word;
        height: auto;
        margin: 0;
        padding: 0;
        }
        table {width: 100%;}
        img {
        width: 100%;
        height: auto;
        }
        iframe {
        width: 100%;
        height: auto;
        }
        </style>
        </head>
        """
        
        //        .wp-caption[style]{width:100% !important;height:auto;}
        //        .wp-caption-text{color:#7a7a7a;font-style:italic;-webkit-text-size-adjust:%ld%;}
        
        headHtml.append("<body>\(self)</body></html>")
        return headHtml
    }
}

extension String {
    func timeAgoDisplay() -> String {
        
        let calendar = Calendar.current
        let minuteAgo = calendar.date(byAdding: .minute, value: -1, to: Date())!
        let hourAgo = calendar.date(byAdding: .hour, value: -1, to: Date())!
        let dayAgo = calendar.date(byAdding: .day, value: -1, to: Date())!
        let weekAgo = calendar.date(byAdding: .day, value: -7, to: Date())!
        
        print("self: \(self)")
        
        let dateFormatter = DateFormatter()
        let stringDate:String = "Thu, 05 Apr 2018 16:21:00 EDT"
        dateFormatter.dateFormat = "E, dd MMM yyyy HH:mm:ss z"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        let date = dateFormatter.date(from:self)!
        
        print("date: \(date)")
        
        if minuteAgo < date {
            let diff = Calendar.current.dateComponents([.second], from: date, to: Date()).second ?? 0
            return "\(diff) sec ago"
        } else if hourAgo < date {
            let diff = Calendar.current.dateComponents([.minute], from: date, to: Date()).minute ?? 0
            return "\(diff) min ago"
        } else if dayAgo < date {
            let diff = Calendar.current.dateComponents([.hour], from: date, to: Date()).hour ?? 0
            return "\(diff) hrs ago"
        } else if weekAgo < date {
            let diff = Calendar.current.dateComponents([.day], from: date, to: Date()).day ?? 0
            return "\(diff) days ago"
        }
        let diff = Calendar.current.dateComponents([.weekOfYear], from: date, to: Date()).weekOfYear ?? 0
        return "\(diff) weeks ago"
    }
}

//http://nsdateformatter.com/
//https://stackoverflow.com/questions/36861732/swift-convert-string-to-date
//https://stackoverflow.com/questions/44086555/swift-time-ago-from-parse-createdat-date
//
//Thu, 05 Apr 2018 16:21:00 EDT
//
//guard let pubdate = article?.pub_date?.toDateString(inputDateFormat: "EE, dd MMM YYYY HH:mm:ss z", ouputDateFormat: "hh:mm a EEEE, MMMM dd, YYYY") else { return }
//
//extension String {
//    func toDateString( inputDateFormat inputFormat  : String,  ouputDateFormat outputFormat  : String ) -> String {
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = inputFormat
//        let date = dateFormatter.date(from: self)
//        dateFormatter.dateFormat = outputFormat
//        return dateFormatter.string(from: date!)
//    }
//}

//let now = Date()
//print("time: \(now.timeAgoDisplay())")
//
//extension Date {
//    func timeAgoDisplay() -> String {
//        
//        let calendar = Calendar.current
//        let minuteAgo = calendar.date(byAdding: .minute, value: -1, to: Date())!
//        let hourAgo = calendar.date(byAdding: .hour, value: -1, to: Date())!
//        let dayAgo = calendar.date(byAdding: .day, value: -1, to: Date())!
//        let weekAgo = calendar.date(byAdding: .day, value: -7, to: Date())!
//        
//        print("self: \(self)")
//        
//        if minuteAgo < self {
//            let diff = Calendar.current.dateComponents([.second], from: self, to: Date()).second ?? 0
//            return "\(diff) sec ago"
//        } else if hourAgo < self {
//            let diff = Calendar.current.dateComponents([.minute], from: self, to: Date()).minute ?? 0
//            return "\(diff) min ago"
//        } else if dayAgo < self {
//            let diff = Calendar.current.dateComponents([.hour], from: self, to: Date()).hour ?? 0
//            return "\(diff) hrs ago"
//        } else if weekAgo < self {
//            let diff = Calendar.current.dateComponents([.day], from: self, to: Date()).day ?? 0
//            return "\(diff) days ago"
//        }
//        let diff = Calendar.current.dateComponents([.weekOfYear], from: self, to: Date()).weekOfYear ?? 0
//        return "\(diff) weeks ago"
//    }
//}
