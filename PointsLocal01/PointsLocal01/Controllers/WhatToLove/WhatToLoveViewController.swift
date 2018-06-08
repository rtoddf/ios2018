import UIKit

class WhatToLoveViewController:UICollectionViewController, UICollectionViewDelegateFlowLayout {
    var menu:Menu? {
        didSet {
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = menu?.title
        navigationController?.navigationBar.tintColor = .white
        collectionView?.backgroundColor = .purple
        collectionView?.alwaysBounceVertical = true
        self.navigationController?.navigationBar.tintColor = .white

        
        collectionView?.dataSource = self
        collectionView?.delegate = self
    }
}
