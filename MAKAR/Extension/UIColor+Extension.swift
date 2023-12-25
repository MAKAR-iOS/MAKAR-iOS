//
//  UIColor+Extension.swift
//  MAKAR
//
//  Created by 박지윤 on 2023/12/25.
//

import UIKit

internal extension UIColor {

    // MARK: - component
    static var background: UIColor {
        return UIColor.load(name: "background")
    }

    static var divider: UIColor {
        return UIColor.load(name: "divider")
    }
    
    // MARK: - point
    static var makarBlue: UIColor {
        return UIColor.load(name: "blue")
    }

    static var makarRed: UIColor {
        return UIColor.load(name: "red")
    }

    static var kakaoYellow: UIColor {
        return UIColor.load(name: "kakao_yellow")
    }

    // MARK: - text
    static var black: UIColor {
        return UIColor.load(name: "black")
    }

    static var darkgray: UIColor {
        return UIColor.load(name: "darkgray")
    }

    static var darkgray2: UIColor {
        return UIColor.load(name: "darkgray2")
    }

    static var lightgray: UIColor {
        return UIColor.load(name: "lightgray")
    }

    static var lightgray2: UIColor {
        return UIColor.load(name: "lightgray2")
    }

    static var lightgray3: UIColor {
        return UIColor.load(name: "lightgray3")
    }

    static var lightgray4: UIColor {
        return UIColor.load(name: "lightgray4")
    }

    static var lightgray5: UIColor {
        return UIColor.load(name: "lightgray5")
    }

    static var white: UIColor {
        return UIColor.load(name: "white")
    }
}

fileprivate extension UIColor {
    static func load(name: String) -> UIColor {
#if SWIFT_PACKAGE
        guard let color = UIColor(named: name, in: .module, compatibleWith: nil) else {
            assert(false, "\(name) 컬러 로드 실패")
            return UIColor.clear
        }
#else
        guard let color = UIColor(named: name, in: MakarBundle.bundle, compatibleWith: nil) else {
            assert(false, "\(name) 컬러 로드 실패")
            return UIColor.clear
        }
#endif
        return color
    }
}

internal class MakarBundle {
    internal static let bundle = Bundle(for: MakarBundle.self)
}
