//
//  text+extension.swift
//  YouVerify
//
//  Created by Samson Oluwapelumi on 11/03/2025.
//

import Foundation
import SwiftUI

extension Text {
    func coloredText(_ color: Color, size: CGFloat, weight: FontManager.AfacadWeight) -> Text {
        self.foregroundColor(color).afacadFont(size, weight: weight)
    }
    
    func afacadFont( _ size: CGFloat, weight: FontManager.AfacadWeight = .regular) -> Text {
        self.font(FontManager.afacad(size, weight: weight))
    }
}
