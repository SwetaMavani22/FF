//
//  EmojiTextView.swift
//  FriendsField
//
//  Created by Scalelot Technologies on 23/05/22.
//

import Foundation
import UIKit

class EmojiTextView: UITextView {

    var hasEmoji = false

    override var textInputMode: UITextInputMode? {
        for mode in UITextInputMode.activeInputModes where (hasEmoji && mode.primaryLanguage == "emoji") {
            return mode
        }
        return nil
    }
}
