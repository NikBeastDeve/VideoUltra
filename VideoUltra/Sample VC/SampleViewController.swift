//
//  SampleViewController.swift
//  VideoUltra
//
//  Created by Nikita Galaganov on 17/03/2023.
//

import UIKit
import SnapKit

struct CustomData {
    var backgroundImage: UIImage
}

final class SampleViewController : UIViewController {
    
    fileprivate let clipGenerator = VideoEngine()
    
    fileprivate let textLoading = "Generating clip and saving to camera roll..."
    fileprivate let textSucceed = "Clip was created and saved to samera roll!"
    
    fileprivate let data = [
        CustomData(backgroundImage: UIImage(named: "example_1")!),
        CustomData(backgroundImage: UIImage(named: "example_2")!),
        CustomData(backgroundImage: UIImage(named: "example_3")!),
        CustomData(backgroundImage: UIImage(named: "example_4")!),
        CustomData(backgroundImage: UIImage(named: "example_5")!),
        CustomData(backgroundImage: UIImage(named: "example_6")!),
        CustomData(backgroundImage: UIImage(named: "example_7")!),
        CustomData(backgroundImage: UIImage(named: "example_8")!)
    ]
                                                               
    fileprivate let collectionView: UICollectionView = {
            let layout = UICollectionViewFlowLayout()
            layout.sectionInset = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
            layout.scrollDirection = .vertical
            let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
            cv.translatesAutoresizingMaskIntoConstraints = false
            cv.register(CustomCell.self, forCellWithReuseIdentifier: "cell")
            return cv
        }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.showsVerticalScrollIndicator = false
 
        view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints { (make) -> Void in
            make.left.right.top.bottom.equalToSuperview()
        }
    }
}

extension SampleViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width/2.3, height: collectionView.frame.width/1.6)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CustomCell
        cell.data = self.data[indexPath.item]
        return cell
    }
}

extension SampleViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       ProgressHUD.show(textLoading)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { [weak self] in
            self?.clipGenerator.makeClip() {
                ProgressHUD.dismiss()
                
                ProgressHUD.showSucceed(self?.textSucceed ?? "", delay: 0.5)
            }
        }
    }
}
