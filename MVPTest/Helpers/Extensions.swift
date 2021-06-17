//
//  Extensions.swift
//  MVPTest
//
//  Created by Bezdenezhnykh Sergey on 16.06.2021.
//

import UIKit

extension UIColor {
    static let primary = #colorLiteral(red: 0.03921568627, green: 0.5176470588, blue: 1, alpha: 1)
}

extension UINavigationController {
    static func create(root: UIViewController) -> UINavigationController {
        let nav = UINavigationController(rootViewController: root)
        nav.view.backgroundColor = .primary
        nav.navigationBar.backgroundColor = .primary
        nav.navigationBar.barTintColor = .primary
        nav.navigationBar.tintColor = UIColor.white
        nav.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        nav.navigationBar.isTranslucent = false
        nav.navigationBar.barStyle = .black
        nav.navigationBar.prefersLargeTitles = false
        return nav
    }
}

class UrlButton: UIButton {
    var urlVideo = ""
}

class AlignableUILabel: UILabel {

    override func drawText(in rect: CGRect) {

        var newRect = CGRect(x: rect.origin.x,y: rect.origin.y,width: rect.width, height: rect.height)
        let fittingSize = sizeThatFits(rect.size)

        if contentMode == UIView.ContentMode.top {
            newRect.size.height = min(newRect.size.height, fittingSize.height)
        } else if contentMode == UIView.ContentMode.bottom {
            newRect.origin.y = max(0, newRect.size.height - fittingSize.height)
        }

        super.drawText(in: newRect)
    }

}
