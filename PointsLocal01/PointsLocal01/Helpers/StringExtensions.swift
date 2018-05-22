import UIKit

extension UIFont {
    static var bodyFont:UIFont {
        guard let font = UIFont(name: "Helvetica", size: 14) else { return UIFont.systemFont(ofSize: 14) }
        return font
    }
    
    static var titleFont:UIFont {
        guard let font = UIFont(name: "Helvetica-Bold", size: 14) else { return UIFont.boldSystemFont(ofSize: 14) }
        return font
    }
    
    static var articleTitleFont:UIFont {
        guard let font = UIFont(name: "Helvetica-Bold", size: 24) else { return UIFont.boldSystemFont(ofSize: 24) }
        return font
    }
    
    static var labelFont:UIFont {
        guard let font = UIFont(name: "Helvetica", size: 11) else { return UIFont.systemFont(ofSize: 11) }
        return font
    }
    
    static var boldLabelFont:UIFont {
        guard let font = UIFont(name: "Helvetica-Bold", size: 10) else { return UIFont.boldSystemFont(ofSize: 10) }
        return font
    }
    
    static var extraLargeFont:UIFont {
        guard let font = UIFont(name: "Helvetica-Bold", size: 18) else { return UIFont.boldSystemFont(ofSize: 18) }
        return font
    }
}
