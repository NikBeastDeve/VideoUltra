//
//  NoTiitleTabBarItem.swift
//  VideoUltra
//
//  Created by Nikita Galaganov on 19/03/2023.
//

import Foundation
import UIKit

final class NoTiitleTabBarItem: UITabBarItem {

    override var title: String? {
        get { return nil }
        set { super.title = title }
    }

    override var imageInsets: UIEdgeInsets {
        get { return UIEdgeInsets(top: 5, left: 0, bottom: -5, right: 0) }
        set { super.imageInsets = imageInsets }
    }

    convenience init(image: UIImage? , selectedImage: UIImage?) {
        self.init()

        self.image = image
        self.selectedImage = image
    }

    override init() {
        super.init()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
