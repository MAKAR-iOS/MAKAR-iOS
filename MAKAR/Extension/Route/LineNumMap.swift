//
//  LineNumImage.swift
//  MAKAR
//
//  Created by 김다은 on 12/29/23.
//

import UIKit
class LineNumImage {
    var lineNumMap: [String: UIImage] = [:]

    func addLineNum(){
        lineNumMap["1호선"] = MakarImage.line1
        lineNumMap["2호선"] = MakarImage.line2
        lineNumMap["3호선"] = MakarImage.line3
        lineNumMap["4호선"] = MakarImage.line4
        lineNumMap["5호선"] = MakarImage.line5
        lineNumMap["6호선"] = MakarImage.line6
        lineNumMap["7호선"] = MakarImage.line7
        lineNumMap["8호선"] = MakarImage.line8
        lineNumMap["9호선"] = MakarImage.line9
        lineNumMap["경의중앙"] = MakarImage.lineK
        lineNumMap["공항철도"] = MakarImage.lineA
        lineNumMap["error"] = MakarImage.line0
    }
}

class LineNumColor {
    var lineNumColorMap : [String : UIColor] = [:]
    
    func addLineNum(){
        lineNumColorMap["1호선"] = .line1
        lineNumColorMap["2호선"] = .line2
        lineNumColorMap["3호선"] = .line3
        lineNumColorMap["4호선"] = .line4
        lineNumColorMap["5호선"] = .line5
        lineNumColorMap["6호선"] = .line6
        lineNumColorMap["7호선"] = .line7
        lineNumColorMap["8호선"] = .line8
        lineNumColorMap["9호선"] = .line9
        lineNumColorMap["경의중앙"] = .lineK
        lineNumColorMap["공항철도"] = .lineA
    }
}
