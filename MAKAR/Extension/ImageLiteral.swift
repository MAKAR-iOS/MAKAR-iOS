//
//  ImageLiteral.swift
//  MAKAR
//
//  Created by 박지윤 on 2023/12/25.
//

import UIKit

public enum MakarImage {
    public static var appleLogo: UIImage { .load(name: "logo_apple")}
    public static var kakaoLogo: UIImage { .load(name: "logo_kakao")}
    public static var makarLogo: UIImage { .load(name: "logo_makar")}
    public static var makarProgress: UIImage { .load(name: "makar_progress")}
    public static var line0: UIImage { .load(name: "ic_line0")}
    public static var line1: UIImage { .load(name: "ic_line1")}
    public static var line2: UIImage { .load(name: "ic_line2") }
    public static var line3: UIImage { .load(name: "ic_line3") }
    public static var line4: UIImage { .load(name: "ic_line4") }
    public static var line5: UIImage { .load(name: "ic_line5") }
    public static var line6: UIImage { .load(name: "ic_line6")}
    public static var line7: UIImage { .load(name: "ic_line7")}
    public static var line8: UIImage { .load(name: "ic_line8")}
    public static var line9: UIImage { .load(name: "ic_line9")}
    public static var lineA: UIImage { .load(name: "ic_lineA")}
    public static var lineK: UIImage { .load(name: "ic_lineK")}
    public static var last: UIImage { .load(name: "ic_last")}
    public static var walk: UIImage { .load(name: "walk")}
    public static var profile: UIImage { .load(name: "profile")}
}

public enum MakarButton {
    public static var addButton: UIImage { .load(name: "ic_add") }
    public static var checkButton: UIImage { .load(name: "ic_check") }
    public static var deleteButton: UIImage { .load(name: "ic_delete") }
    public static var homeButton: UIImage { .load(name: "ic_home") }
    public static var homeFilledButton: UIImage { .load(name: "ic_home_filled") }
    public static var mapButton: UIImage { .load(name: "ic_map") }
    public static var moreBottomButton: UIImage { .load(name: "ic_more_bottom") }
    public static var moreRightButton: UIImage { .load(name: "ic_more_right") }
    public static var myLocationButton: UIImage { .load(name: "ic_my_location") }
    public static var myPageButton: UIImage { .load(name: "ic_my_page") }
    public static var myPageFilledButton: UIImage { .load(name: "ic_my_page_filled") }
    public static var myRouteButton: UIImage { .load(name: "ic_my_route") }
    public static var notificationButton: UIImage { .load(name: "ic_notification") }
    public static var notificationFilledButton: UIImage { .load(name: "ic_notification_filled") }
    public static var schoolButton: UIImage { .load(name: "ic_school") }
    public static var starButton: UIImage { .load(name: "ic_star") }
    public static var subwayButton: UIImage { .load(name: "ic_subway") }
    public static var swapButton: UIImage { .load(name: "ic_swap") }
    public static var timetableButton: UIImage { .load(name: "ic_timetable") }
    public static var timetableFilledButton: UIImage { .load(name: "ic_timetable_filled") }
}

extension UIImage {
    static func load(name: String) -> UIImage {
        guard let image = UIImage(named: name, in: nil, compatibleWith: nil) else {
            return UIImage()
        }
        image.accessibilityIdentifier = name
        return image
    }
}
