//
//
//  Copyright © 2021 ANameBehindTheNickname. All rights reserved.
//

import UIKit

extension UIView {
    func applyAppDefaultShadow() {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.15
        layer.shadowOffset = .init(width: 0, height: 1)
        layer.shadowRadius = 2
        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.main.scale
    }
}
