//
//  AkiraTextField.swift
//  TextFieldEffects
//
//  Created by Mihaela Miches on 5/31/15.
//  Copyright (c) 2015 Raul Riera. All rights reserved.
//

import UIKit

/**
 An AkiraTextField is a subclass of the TextFieldEffects object, is a control that displays an UITextField with a customizable visual effect around the edges of the control.
 */
@IBDesignable open class AkiraTextField : TextFieldEffects {
	private let borderSize: (active: CGFloat, inactive: CGFloat) = (2, 1)
    private let borderLayer = CALayer()
    private let textFieldInsets = CGPoint(x: 15, y: 0)
    private let placeholderInsets = CGPoint(x: 15, y: 0)
    
    /**
     The color of the border.
     
     This property applies a color to the bounds of the control. The default value for this property is a clear color.
    */
    @IBInspectable dynamic open var inactiveColor: UIColor? {
        
        didSet {
            updateBorder()
        }
    }
    
    /**
     The color of the border when it has content.
     
     This property applies a color to the lower edge of the control. The default value for this property is a clear color.
     */
    @IBInspectable dynamic open var activeColor: UIColor? {
        didSet {
            updateBorder()
        }
    }
    
    /**
     The scale of the placeholder font.
     
     This property determines the size of the placeholder label relative to the font size of the text field.
     */
    @IBInspectable dynamic open var placeholderFontScale: CGFloat = 0.8 {
        didSet {
            updatePlaceholder()
        }
    }
    
    override open var placeholder: String? {
        didSet {
            updatePlaceholder()
        }
    }
    
    override open var bounds: CGRect {
        didSet {
            updateBorder()
        }
    }
    
    // MARK: TextFieldEffects
    
    override open func drawViewsForRect(_ rect: CGRect) {
        updateBorder()
        updatePlaceholder()
        
        addSubview(placeholderLabel)
        layer.addSublayer(borderLayer)
    }
    
    override open func animateViewsForTextEntry() {
        UIView.animate(withDuration: 0.3, animations: {
            self.updateBorder()
            self.updatePlaceholder()
        }, completion: { _ in
            self.animationCompletionHandler?(.textEntry)
        })
    }
    
    override open func animateViewsForTextDisplay() {
        UIView.animate(withDuration: 0.3, animations: {
            self.updateBorder()
            self.updatePlaceholder()
        }, completion: { _ in
            self.animationCompletionHandler?(.textDisplay)
        })
    }
    
    // MARK: Private
    
    private func updatePlaceholder() {
        placeholderLabel.frame = placeholderRect(forBounds: bounds)
        placeholderLabel.text = placeholder
        placeholderLabel.font = (isFirstResponder || text!.isNotEmpty) ? placeholderFontFromFont(font!) : placeholderFontFromDefaultFont(font!)
        placeholderLabel.textColor = (isFirstResponder || text!.isNotEmpty) ? activeColor : inactiveColor
        placeholderLabel.textAlignment = textAlignment
    }
    
    private func updateBorder() {
        borderLayer.frame = rectForBounds(bounds)
        borderLayer.borderWidth = (isFirstResponder || text!.isNotEmpty) ? borderSize.active : borderSize.inactive
        borderLayer.borderColor = (isFirstResponder || text!.isNotEmpty) ? activeColor?.cgColor : inactiveColor?.cgColor
        borderLayer.cornerRadius = 5.0
    }
    
    private func placeholderFontFromDefaultFont(_ font: UIFont) -> UIFont! {
     let smallerFont = UIFont(descriptor: font.fontDescriptor, size: font.pointSize * 1)
        return smallerFont
    }
    
    private func placeholderFontFromFont(_ font: UIFont) -> UIFont! {
     let smallerFont = UIFont(descriptor: font.fontDescriptor, size: font.pointSize * placeholderFontScale)
        return smallerFont
    }
    
    private var placeholderHeight : CGFloat {
        return placeholderInsets.y + placeholderFontFromFont(font!).lineHeight
    }
    
    private func rectForBounds(_ bounds: CGRect) -> CGRect {
        return CGRect(x: bounds.origin.x, y: bounds.origin.y + placeholderHeight, width: bounds.size.width, height: bounds.size.height - placeholderHeight)
    }
    
    // MARK: - Overrides
    
    open override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        if isFirstResponder || text!.isNotEmpty {
            return CGRect(x: placeholderInsets.x, y: placeholderInsets.y, width: bounds.width, height: placeholderHeight)
        } else {
            return textRect(forBounds: bounds)
        }
    }
    
    open override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: textFieldInsets.x, y: textFieldInsets.y + placeholderHeight, width: bounds.size.width - (textFieldInsets.x * 2) - 5, height: bounds.size.height - placeholderHeight)
    }
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: textFieldInsets.x, y: textFieldInsets.y + placeholderHeight, width: bounds.size.width - (textFieldInsets.x * 2) - 5, height: bounds.size.height - placeholderHeight)
    }
}

