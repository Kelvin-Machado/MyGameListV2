//
//  Color.swift
//  MyGameListV2
//
//  Created by Kelvin Batista Machado on 02/01/24.
//

import UIKit

struct Color {
    static var clear = UIColor.clear
    
    //Cores primárias e secundárias
    static var primary = UIColor(hexString: "#000000")
    static var secondary = UIColor(hexString: "#222222")
    
    //cores de fundo
    static var background = UIColor(hexString: "#555555")
    private static var backgroundGradient1 = UIColor(hexString: "#191a1b")
    private static var backgroundGradient2 = UIColor(hexString: "#303030")
    static var backgroundGradient: [UIColor] = [Color.uiColor(Color.backgroundGradient1), Color.uiColor(Color.backgroundGradient2), Color.uiColor(Color.backgroundGradient1)]
    
    static var buttonBackground = UIColor(hexString: "C0C0C0")
    static var buttonText = UIColor(hexString: "FFFFFF")
    
    //outras cores
    static var lightCyan = UIColor(hexString: "E0FFFF")
    static var steelBlue = UIColor(hexString: "4682B4")
    static var lightSteelBlue = UIColor(hexString: "B0C4DE")
    static var midnightBlue = UIColor(hexString: "191970")
    
    static var white = UIColor(hexString: "FFFFFF")
    static var whiteSmoke = UIColor(hexString: "F5F5F5")
    
    static var gainsboro = UIColor(hexString: "DCDCDC")
    static var lightGray = UIColor(hexString: "D3D3D3")
    static var silver = UIColor(hexString: "C0C0C0")
    static var darkGray = UIColor(hexString: "A9A9A9")
    static var gray = UIColor(hexString: "808080")
    static var dimGray = UIColor(hexString: "696969")
    
    static var black = UIColor(hexString: "000000")
    
    struct TextColor {
        static var title = UIColor(hexString: "FFFFFF")
        static var subtitle = UIColor(hexString: "A0A0A0")
        static var description = UIColor(hexString: "808080")
        static var primary = UIColor(hexString: "FFFFFF")
        static var secondary = UIColor(hexString: "C0C0C0")
    }
    
    static func uiColor(_ color: UIColor?) -> UIColor {
        return color ?? UIColor.clear
    }

}
