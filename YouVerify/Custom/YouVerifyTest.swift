//
//  FinTrackText.swift
//  YouVerify
//
//  Created by Samson Oluwapelumi on 11/03/2025.
//

import SwiftUI

struct FinTrackText: View {
    let text: String
    let size: CGFloat
    let weight: FontManager.AfacadWeight
    let color: Color?
    let highlightText: String?
    let textAlignment: TextAlignment
    
    @Environment(\.colorScheme) private var colorScheme
    
    init(
        _ text: String,
        size: CGFloat = 14,
        weight: FontManager.AfacadWeight = .regular,
        color: Color? = nil,
        highlightText: String? = nil,
        textAlignment: TextAlignment = .leading
    ) {
        self.text = text
        self.size = size
        self.weight = weight
        self.color = color
        self.highlightText = highlightText
        self.textAlignment = textAlignment
    }
    
    var body: some View {
        let textColor = color ?? (colorScheme == .dark ? .white : .black)
        
        if let highlightText, text.contains(highlightText) {
            let parts = text.components(separatedBy: highlightText)
            return Text("\(Text(parts[0]).font(.custom("Capriola-Regular", size: size)).foregroundColor(textColor))\(Text(highlightText).font(.custom("Capriola-Regular", size: size)).foregroundColor(textColor))\(Text(parts.count > 1 ? parts[1] : "").font(.custom("Capriola-Regular", size: size)).foregroundColor(textColor))")
                .multilineTextAlignment(textAlignment)
        } else {
            return Text(text)
                .font(.custom("Capriola-Regular", size: size))
                .foregroundColor(textColor)
                .multilineTextAlignment(textAlignment)
        }
    }
}
