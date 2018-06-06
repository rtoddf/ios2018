import UIKit

class VideoLauncher:NSObject {
    
    func showVideoPlayer() {
        print("show video player")
        
        // we con't have access to views because we're using NSOnject
        // so we need to access keywindow
        if let keyWindow = UIApplication.shared.keyWindow {
            let view = UIView(frame: keyWindow.frame)
            view.backgroundColor = .purple
            
            // animations need a beginning and ending frame
            view.frame = CGRect(x: keyWindow.frame.width - 10, y: keyWindow.frame.height - 10, width: 10, height: 10)
            
            keyWindow.addSubview(view)
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                view.frame = keyWindow.frame
            }) { (completedAnimation) in
                // do something later
            }
        }
    }
}
