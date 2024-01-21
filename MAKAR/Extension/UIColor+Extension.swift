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

    static var darkGray: UIColor {
        return UIColor.load(name: "darkgray")
    }

    static var darkGray2: UIColor {
        return UIColor.load(name: "darkgray2")
    }

    static var lightGray: UIColor {
        return UIColor.load(name: "lightgray")
    }

    static var lightGray2: UIColor {
        return UIColor.load(name: "lightgray2")
    }

    static var lightGray3: UIColor {
        return UIColor.load(name: "lightgray3")
    }

    static var lightGray4: UIColor {
        return UIColor.load(name: "lightgray4")
    }

    static var lightGray5: UIColor {
        return UIColor.load(name: "lightgray5")
    }

    static var white: UIColor {
        return UIColor.load(name: "white")
    }
    
    // MARK: - lineNum
    static var line0 : UIColor {
        return UIColor.load(name: "line0")
    }
    
    static var line1 : UIColor {
        return UIColor.load(name: "line1")
    }
    
    static var line2 : UIColor {
        return UIColor.load(name: "line2")
    }
    
    static var line3 : UIColor {
        return UIColor.load(name: "line3")
    }
    
    static var line4 : UIColor {
        return UIColor.load(name: "line4")
    }
    
    static var line5 : UIColor {
        return UIColor.load(name: "line5")
    }
    
    static var line6 : UIColor {
        return UIColor.load(name: "line6")
    }
    
    static var line7 : UIColor {
        return UIColor.load(name: "line7")
    }
    
    static var line8 : UIColor {
        return UIColor.load(name: "line8")
    }
    
    static var line9 : UIColor {
        return UIColor.load(name: "line9")
    }
    
    static var lineA : UIColor {
        return UIColor.load(name: "lineA")
    }
    
    static var lineK : UIColor {
        return UIColor.load(name: "lineK")
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
