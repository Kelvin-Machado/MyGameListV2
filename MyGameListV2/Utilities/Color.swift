//
//  Color.swift
//  MyGameListV2
//
//  Created by Kelvin Batista Machado on 02/01/24.
//

import UIKit

struct Color {
    //Cores primárias e secundárias
    static var primary = UIColor(hexString: "#000000", alpha: 1)
    static var secondary = UIColor(hexString: "#222222", alpha: 1)
    
    //cores de fundo
    static var background = UIColor(hexString: "#DCDCDC", alpha: 1)
    
    static var buttonBackground = UIColor(hexString: "YourButtonBackgroundColorHex", alpha: 1)
    static var buttonText = UIColor(hexString: "YourButtonTextColorHex", alpha: 1)
    
    //outras cores
    static var lightCyan = UIColor(hexString: "E0FFFF", alpha: 1)
    static var steelBlue = UIColor(hexString: "4682B4", alpha: 1)
    static var lightSteelBlue = UIColor(hexString: "B0C4DE", alpha: 1)
    static var midnightBlue = UIColor(hexString: "191970", alpha: 1)
    
    static var white = UIColor(hexString: "FFFFFF", alpha: 1)
    static var whiteSmoke = UIColor(hexString: "F5F5F5", alpha: 1)
    
    static var gainsboro = UIColor(hexString: "DCDCDC", alpha: 1)
    static var lightGray = UIColor(hexString: "D3D3D3", alpha: 1)
    static var silver = UIColor(hexString: "C0C0C0", alpha: 1)
    static var darkGray = UIColor(hexString: "A9A9A9", alpha: 1)
    static var gray = UIColor(hexString: "808080", alpha: 1)
    static var dimGray = UIColor(hexString: "696969", alpha: 1)
    
    static var black = UIColor(hexString: "000000", alpha: 1)
    
    struct TextColor {
        static var title = UIColor(hexString: "FFFFFF", alpha: 1)  // Branco para títulos
        static var subtitle = UIColor(hexString: "A0A0A0", alpha: 1)  // Cinza claro para subtítulos
        static var description = UIColor(hexString: "808080", alpha: 1)  // Cinza médio para descrições
        static var primary = UIColor(hexString: "FFFFFF", alpha: 1)  // Branco para texto principal
        static var secondary = UIColor(hexString: "C0C0C0", alpha: 1)  // Prata para texto secundário
    }

}
