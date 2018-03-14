import UIKit

extension String {
    func toDateString( inputDateFormat inputFormat  : String,  ouputDateFormat outputFormat  : String ) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = inputFormat
        let date = dateFormatter.date(from: self)
        dateFormatter.dateFormat = outputFormat
        return dateFormatter.string(from: date!)
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

extension String {
    func wrapHTML() -> String {
        let fontSize:String = "14px"
        
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
