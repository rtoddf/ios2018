import UIKit
import AVFoundation

class VideoPlayerView:UIView {
    
    let activityIndicatorView:UIActivityIndicatorView = {
        let aiv = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        aiv.translatesAutoresizingMaskIntoConstraints = false
        aiv.startAnimating()
        return aiv
    }()
    
    lazy var pausePlayButton:UIButton = {
        let btn = UIButton(type: .system)
        let image = UIImage(named: "pause")
        btn.setImage(image, for: .normal)
        btn.tintColor = .white
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(handlePause), for: .touchUpInside)
        btn.isHidden = true
        return btn
    }()
    
    var isPLaying:Bool = false
    
    @objc func handlePause(){
        if isPLaying {
            player?.pause()
            pausePlayButton.setImage(UIImage(named: "play"), for: .normal)
        } else {
            player?.play()
            pausePlayButton.setImage(UIImage(named: "pause"), for: .normal)
        }

        isPLaying = !isPLaying
    }
    
    let controlsContainerView:UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0, alpha: 1)
        return view
    }()
    
    let videoCurrentTimeLabel:UILabel = {
        let label = UILabel()
        label.text = "00:00"
        label.font = UIFont.boldSystemFont(ofSize: 13)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let videoLengthLabel:UILabel = {
        let label = UILabel()
        label.text = "00:00"
        label.font = UIFont.boldSystemFont(ofSize: 13)
        label.textColor = .white
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var videoSlider:UISlider = {
        let slider = UISlider()
        slider.minimumTrackTintColor = .orange
        slider.maximumTrackTintColor = .white
        slider.setThumbImage(UIImage(named: "thumb"), for: .normal)
        slider.translatesAutoresizingMaskIntoConstraints = false
        
        slider.addTarget(self, action: #selector(handleSliderChanged), for: .valueChanged)
        
        return slider
    }()
    
    @objc func handleSliderChanged(){
        print(videoSlider.value)
        
        guard let duration  = player?.currentItem?.duration else { return }
        let totalSeconds = CMTimeGetSeconds(duration)
        let value = Float(totalSeconds) * videoSlider.value
        let seekTime = CMTime(value: CMTimeValue(value), timescale: 1)
        
        player?.seek(to: seekTime, completionHandler: { (completedSeek) in
            // do other things
        })
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        backgroundColor = .black
        setupPlayerView()
        setupUIElements()
    }
    
    func setupUIElements(){
        controlsContainerView.frame = frame
        addSubview(controlsContainerView)
        
        controlsContainerView.addSubview(activityIndicatorView)
        activityIndicatorView.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0).isActive = true
        activityIndicatorView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 0).isActive = true
        
        controlsContainerView.addSubview(pausePlayButton)
        pausePlayButton.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0).isActive = true
        pausePlayButton.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 0).isActive = true
        pausePlayButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        pausePlayButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        controlsContainerView.addSubview(videoCurrentTimeLabel)
        videoCurrentTimeLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 8).isActive = true
        videoCurrentTimeLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 4).isActive = true
        videoCurrentTimeLabel.widthAnchor.constraint(equalToConstant: 50).isActive = true
        videoCurrentTimeLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        controlsContainerView.addSubview(videoLengthLabel)
        videoLengthLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -8).isActive = true
        videoLengthLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 4).isActive = true
        videoLengthLabel.widthAnchor.constraint(equalToConstant: 50).isActive = true
        videoLengthLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        controlsContainerView.addSubview(videoSlider)
        videoSlider.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -6).isActive = true
        videoSlider.rightAnchor.constraint(equalTo: videoLengthLabel.leftAnchor, constant: 0).isActive = true
        videoSlider.leftAnchor.constraint(equalTo: videoCurrentTimeLabel.rightAnchor, constant: 0).isActive = true
        videoSlider.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    var player:AVPlayer?
    
    func setupPlayerView(){
        let urlString = "http://rtodd.net/swift/video/wildlife.mp4"
        if let url = NSURL(string: urlString) {
            player = AVPlayer(url: url as URL)
            let playerLayer = AVPlayerLayer(player: player)
            self.layer.addSublayer(playerLayer)
            playerLayer.frame = self.frame
            player?.play()
            
            
            player?.addObserver(self, forKeyPath: "currentItem.loadedTimeRanges", options: .new, context: nil)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "currentItem.loadedTimeRanges" {
            activityIndicatorView.stopAnimating()
            controlsContainerView.backgroundColor = .clear
            pausePlayButton.isHidden = false
            isPLaying = true
            
            // this gives you a CMTime reference
            guard let duration = player?.currentItem?.duration else { return }
            let seconds = CMTimeGetSeconds(duration)
            
            let minuteText = String(format: "%02d", Int(seconds) / 60)
            let secondsText = Int(seconds) % 60
            
            videoLengthLabel.text = "\(minuteText):\(secondsText)"
        }
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
