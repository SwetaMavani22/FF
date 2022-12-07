//
//  SCStyle.swift
//  StarCall
//
//  Created by Soumil on 7/1/20.
//  Copyright © 2020 Techno Exponent. All rights reserved.
//

import UIKit

public enum SCFontType: String, CustomStringConvertible {

    case bold = "Roboto-Bold"
    case light = "Roboto-Light"
    case regular = "Roboto-Regular"
    case medium = "Roboto-Medium"
    case thin = "Roboto-Thin"

    public var description: String {
        return "SCStyleDescription : Font name : \(fontName)"
    }

    public var fontName: String {
        return rawValue
    }

    public var fontWeight: CGFloat {
        switch self {
        case .light: return UIFont.Weight.light.rawValue
        case .regular: return UIFont.Weight.regular.rawValue
        case .thin: return UIFont.Weight.thin.rawValue
        case .bold: return UIFont.Weight.bold.rawValue
        case .medium: return UIFont.Weight.medium.rawValue
        }
    }

    //Retrive font of given type. In case of failure provide system font.
    public func font(with pointSize: CGFloat) -> UIFont {
        if let font = UIFont(name: fontName, size: pointSize) {
            return font
        } else {
            return UIFont.systemFont(ofSize: pointSize)
        }
    }

    public func font(with pointSize: SCSizeType) -> UIFont {
        return font(with: pointSize.fontSize)
    }
}

public enum SCSizeType: CGFloat, RawRepresentable, CustomStringConvertible {

    public typealias RawValue = CGFloat
    case txtLbl
    case tiny
    case small
    case compact
    case medium
    case normal
    case big
    case xl
    case xxl
    case xxxl

    public var rawValue: RawValue {
        switch self {
        case .tiny: return UIDevice.isiPad ? 22.0 : 14.0
        case .small: return UIDevice.isiPad ? 18.0 : 12.0
        case .normal: return UIDevice.isiPad ? 22.0 : 16.0
        case .medium:  return UIDevice.isiPad ? 29.0 : 21.0
        case .compact: return UIDevice.isiPad ? 31.0 : 22.0
        case .big: return UIDevice.isiPad ? 20.0 : 18.0
        case .xl: return UIDevice.isiPad ? 34.0 : 24.0
        case .xxl: return UIDevice.isiPad ? 47.0 : 32.0
        case .xxxl: return UIDevice.isiPad ? 77.0 : 67.0
        case .txtLbl: return UIDevice.isiPad ? 20.0 : 12.0
        }
    }

    public var description: String {
        return "SCfont Size :\(fontSize)"
    }

    public var fontSize: CGFloat {
        return rawValue
    }
}

/**
 Color types used in our project. All groups mentioned for clarity.
 
 - white: White color is used in various text elements in this Project.
 - orange: orange is the main theme in this project. It is used in various Heading fields and in some icons
 - lightBlack: lightBlack color used for data text for showing details of various documents.
 - lightSkyBlue: lightSkyBlue is used in some button text and to make the border of those buttons
 - darkBrown: darkBrown is used in some button text and to make the border of those buttons
 - deepBlue: deepBlue is used in label text of dashboard of admin
 - lightGray: lightGray is used in some heading in Task Details Sereen
 - veryLightGray: veryLightGray is used in Heavy Vehicle Permission NOC screen as descripsion
 - lightBlue: lightBlue is used in the forgot password text
 */

public enum SCColorType: String {
    case white//#ffffff
    case theme//#00708B
    case gray//#434343
    case lightGray//#9A9A9A
    case ash //#ebebeb
    case black//#000000
    case darkGray//404040
    case lightBlack//333333
    case deepAsh//#a7a9ab
    case red//#FF0000
    case blueBlack//#2e2f33
    case bgAsh//#ededed
    case bgDeepAsh //#4b4e53
    case backgroundGrey //#d0d2d3
    case lightGreen//#bdd8db
    case unsclt//#4B4E53
    case unSlctTabBar//747778
    public var color: UIColor {
        return color(for: self)
    }

    private func color(for description: SCColorType) -> UIColor {
        switch description {
        case .white: return UIColor(hexString: "ffffff")
        case .theme: return UIColor(hexString: "5AC8D2")
        case .gray: return UIColor(hexString: "F0F0F0")
        case .black: return UIColor(hexString: "000000")
        case .lightGray: return UIColor(hexString: "9A9A9A")
        case .ash: return UIColor(hexString: "ebebeb")
        case .darkGray: return UIColor(hexString: "404040")
        case .lightBlack: return UIColor(hexString: "333333")
        case .deepAsh: return UIColor(hexString: "a7a9ab")
        case .red: return UIColor(hexString: "FF0000")
        case .blueBlack: return UIColor(hexString: "2e2f33")
        case .bgAsh: return UIColor(hexString: "ededed")
        case .bgDeepAsh: return UIColor(hexString: "4b4e53")
        case .backgroundGrey: return UIColor(hexString: "d0d2d3")
        case .lightGreen: return UIColor(hexString: "bdd8db")
       // case .unsclt: return UIColor(hexString: "A3A9AC")
        case .unsclt: return UIColor(hexString: "4B4E53")
        case .unSlctTabBar: return UIColor(hexString: "747778")
        }
    }
}

open class SCStyle: CustomStringConvertible {

    fileprivate let fontType: SCFontType
    fileprivate let sizeType: SCSizeType
    fileprivate let colorType: SCColorType

    public init (fontType: SCFontType, sizeType: SCSizeType, colorType: SCColorType) {
        self.fontType = fontType
        self.sizeType = sizeType
        self.colorType = colorType
    }

    var font: UIFont {
        return fontType.font(with: sizeType)
    }

    open var description: String {
        return "SCStyle: \(fontType) : \(sizeType) : \(colorType)"
    }

    public static var paragrahStyle: NSParagraphStyle {
        let paragraph = NSMutableParagraphStyle()
        paragraph.alignment = .left
        paragraph.lineSpacing = 4.0
        paragraph.paragraphSpacing = 4.0
        return paragraph
    }

    public static var themeFillBtnStyle: SCStyle {
        return SCStyle(fontType: .regular, sizeType: .normal, colorType: .white)
    }

    public static var whiteFillBtnStyle: SCStyle {
        return SCStyle(fontType: .regular, sizeType: .normal, colorType: .theme)
    }

    public static var linkBtnStyle: SCStyle {
        return SCStyle(fontType: .medium, sizeType: .tiny, colorType: .theme)
    }

    public static var cancelBtnStyle: SCStyle {
        return SCStyle(fontType: .regular, sizeType: .tiny, colorType: .gray)
    }

    public static var inviteBtnStyle: SCStyle {
        return SCStyle(fontType: .regular, sizeType: .tiny, colorType: .theme)
    }

    public static var normalBlackText: SCStyle {
        return SCStyle(fontType: .regular, sizeType: .normal, colorType:  .black)
    }

    public static var normalLightGrayText: SCStyle {
        return SCStyle(fontType: .regular, sizeType: .normal, colorType:  .lightGray)
    }

    public static var mediumBoldBlackText: SCStyle {
        return SCStyle(fontType: .bold, sizeType: .medium, colorType: .black)
    }

    public static var normalWhiteText: SCStyle {
        return SCStyle(fontType: .regular, sizeType: .normal, colorType: .white)
    }
    
    public static var normalThemeText: SCStyle {
        return SCStyle(fontType: .regular, sizeType: .normal, colorType: .theme)
    }

    public static var tinyGrayText: SCStyle {
        return SCStyle(fontType: .regular, sizeType: .tiny, colorType: .gray)
    }
    
    
    public static var slctTextField: SCStyle {
        return SCStyle(fontType: .regular, sizeType: .txtLbl, colorType:  .theme)
    }
    
    public static var unSlctTextField: SCStyle {
        return SCStyle(fontType: .regular, sizeType: .txtLbl, colorType: .unsclt)
    }
    
    public static var tinyBlackText: SCStyle {
        return SCStyle(fontType: .regular, sizeType: .tiny, colorType: .black)
    }

    public static var tinyLightGrayText: SCStyle {
        return SCStyle(fontType: .regular, sizeType: .tiny, colorType: .lightGray)
    }

    public static var tinyThemeText: SCStyle {
        return SCStyle(fontType: .regular, sizeType: .tiny, colorType: .theme)
    }
    
    public static var smallThemeText: SCStyle {
        return SCStyle(fontType: .regular, sizeType: .small, colorType: .theme)
    }

    public static var tinyWhiteText: SCStyle {
        return SCStyle(fontType: .regular, sizeType: .tiny, colorType: .white)
    }

    public static var smallBlackText: SCStyle {
        return SCStyle(fontType: .regular, sizeType: .small, colorType: .black)
    }

    public static var smallWhiteText: SCStyle {
        return SCStyle(fontType: .regular, sizeType: .small, colorType: .white)
    }

    public static var smallLightGrayText: SCStyle {
        return SCStyle(fontType: .regular, sizeType: .small, colorType: .lightGray)
    }

    public static var smallAshText: SCStyle {
        return SCStyle(fontType: .regular, sizeType: .small, colorType: .deepAsh)
    }

    public static var largeHeadingText: SCStyle {
        return SCStyle(fontType: .bold, sizeType: .xxl, colorType: .black)
    }

    public static var largeWhiteHeadingText: SCStyle {
        return SCStyle(fontType: .bold, sizeType: .xl, colorType: .white)
    }

    public static var smallHeadingText: SCStyle {
        return SCStyle(fontType: .bold, sizeType: .xl, colorType: .black)
    }

    public static var mediumBlackText: SCStyle {
        return SCStyle(fontType: .medium, sizeType: .normal, colorType: .black)
    }
    
    public static var mediumThemeText: SCStyle {
        return SCStyle(fontType: .medium, sizeType: .normal, colorType: .theme)
    }

    public static var blackTextMediumSize: SCStyle {
        return SCStyle(fontType: .regular, sizeType: .medium, colorType: .black)
    }

    public static var blackTextCompactSize: SCStyle {
        return SCStyle(fontType: .regular, sizeType: .compact, colorType: .black)
    }
    //List of all the fonts in the system.
    func listAllFonts() {
        for family: String in UIFont.familyNames {
            print("\(family)")
            for names: String in UIFont.fontNames(forFamilyName: family) {
                print("== \(names)")
            }
        }
    }
}

// MARK: Extentions

public extension NSAttributedString {

    static func attributedString(text: String, style: SCStyle) -> NSAttributedString {
        let font = style.font
        let textColor = style.colorType.color
        let attributedString = NSMutableAttributedString(string: text, attributes: [
                                                            .font: font ,
                                                            .foregroundColor: textColor] )
        return attributedString
    }
}

public extension UILabel {

    func apply(style: SCStyle) {
        font = style.font
        textColor = style.colorType.color
    }
}

public extension UITextView {

    func apply(style: SCStyle) {
        font = style.font
        textColor = style.colorType.color
    }
}

public extension UITextField {

    func apply(style: SCStyle) {
        font = style.font
        textColor = style.colorType.color
    }
}

public extension UIButton {

    func apply(style: SCStyle, forState state: UIControl.State = .normal) {
        setTitleColor(style.colorType.color, for: state)

        if let title = title(for: state) {
            let attributed = NSAttributedString.attributedString(text: title, style: style)
            setAttributedTitle(attributed, for: state)
        }
    }
}
