import UIKit
import AVFoundation

class VideoPlayerView:UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .orange
        
        let urlString = "http://rtodd.net/swift/video/wildlife.mp4"
        if let url = NSURL(string: urlString) {
            let player = AVPlayer(url: url as URL)
            let playerLayer = AVPlayerLayer(player: player)
            self.layer.addSublayer(playerLayer)
            playerLayer.frame = self.frame
            player.play()
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

class VideoLauncher:NSObject {
    func showVideoPlayer() {
        print("show video player")
        
        // we con't have access to views because we're using NSOnject
        // so we need to access keywindow
        if let keyWindow = UIApplication.shared.keyWindow {
            let view = UIView(frame: keyWindow.frame)
            view.backgroundColor = .white
            
            let videoHeight = keyWindow.frame.width * 9 / 16
            let videoPlayerView = VideoPlayerView(frame: CGRect(x: 0, y: 0, width: keyWindow.frame.width, height: videoHeight))
            view.addSubview(videoPlayerView)
            
            // animations need a beginning and ending frame
            view.frame = CGRect(x: keyWindow.frame.width - 10, y: keyWindow.frame.height - 10, width: 10, height: 10)
            
            keyWindow.addSubview(view)
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                view.frame = keyWindow.frame
            }) { (completedAnimation) in
                UIApplication.shared.isStatusBarHidden = true
            }
        }
    }
}
